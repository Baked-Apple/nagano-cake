class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!
	
	# today,member,allで分岐して表示内容を変更
	def index
		case params[:order]
		# 本日の注文一覧（admin/topから）
		when 'today'
			@orders = Order.page(params[:page]).reverse_order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
		#会員の注文履歴一覧（会員のマイページから)
		when 'member'
			member_id = Rails.application.routes.recognize_path(request.referer)[:id]
			@member = Member.find(member_id)
			@orders = @member.orders.page(params[:page]).reverse_order
		#admin/注文履歴一覧（ヘッダーから）
		when 'all'
		    @orders = Order.page(params[:page]).reverse_order
		    # 検索オブジェクト
			@search = Order.ransack(params[:q])
			# 検索結果
			@q_orders = @search.result.page(params[:page]).reverse_order
		end
	end


	def show
		@order = Order.find(params[:id])
		case @order.pay_type
			when "credit" then
				@pay = "クレジットカード"
			when "bank" then
				@pay = "銀行振込"
			end
	end

	def update
		@order = Order.find(params[:id])
		order_items = @order.order_items.all
		if @order.update(order_params)
			# 注文状況が１＝入金確認になったら、製作待ち１に
			if @order.order_status == "confirmed"
				order_items.each do |order_item|
					order_item.update(product_status: 1)
				end
			end
			redirect_to admin_order_path(@order.id), notice:'ステータスを更新しました'
		end
	end

	private
    def order_params
      params.require(:order).permit(:total_fee, :postage, :pay_type, :postal_code, :address, :delivery_name, :order_status, :product_status)
    end


end
