class Admin::OrdersController < ApplicationController

	# today,member,allで分岐して表示内容を変更
	def index
		case params[:order]
		# 本日の注文一覧（admin/topから）
		when 'today'
			@orders = Order.all.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
		#会員の注文履歴一覧
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
	end

	def update
		@order = Order.find(params[:id])
		if @order.update(order_params)
			redirect_to public_orders_path
		else
			render :edit
		end
	end

end
