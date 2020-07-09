class Admin::OrdersController < ApplicationController

	# today,member,allで分岐して表示内容を変更
	def index
		case params[:order]
		# 本日の注文一覧（admin/topから）
		when 'today'
			@orders = Order.all.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
		#会員の注文履歴一覧（会員のマイページから)
		when 'member'
			member_id = Rails.application.routes.recognize_path(request.referer)[:id]
			@member = Member.find(member_id)
			@orders = @member.orders.all
		#admin/注文履歴一覧（ヘッダーから）
		when 'all'
			@orders = Order.all
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
		if @order.update(order_params)
			# 注文状況が１＝入金確認になったら、製作待ち１に
		 	if @order_status == "confirmed"
		 		@order_item.update(product_status: 1)
		 	end
		 	redirect_to admin_order_path(@order.id)
		end
    end


	 	# # 製作状況が２＝製作中になったら、注文ステータスを製作中２に
	 	# elsif @product_status == 2
	 	# 	@order.update(order_status: 2)
	 	# # 製作状況が３＝製作完了になったら、注文ステータスを発送準備中３に
	 	# elsif @product_status == 3
	 	# 	@order_item.update(product_status: 3)


	private
    def order_params
      params.require(:order).permit(:total_fee, :postage, :pay_type, :postal_code, :address, :delivery_name, :order_status, :product_status)
    end


end
