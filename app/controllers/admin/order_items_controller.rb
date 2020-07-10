class Admin::OrderItemsController < ApplicationController

	def update
		@order_item = OrderItem.find(params[:id])
		# order_itemに紐づくorderを代入
		@order = @order_item.order
		@order_item.order_id = @order.id
		@order_item.update(order_item_params)
		# 製作状況が２＝製作中になったら、注文ステータスを製作中２に
		if @order_item.product_status == "making"
			@order.update(order_status: 2)
		# 全ての注文商品の製作状況が３＝製作完了になったら、注文ステータスを発送準備中３に
		elsif @order.order_items.all?{|n|n.product_status == "done"}
			@order.update(order_status: 3)
		end
		redirect_to admin_order_path(@order.id)
    end

    def order_item_params
    	params.require(:order_item).permit(:product_status)
	end

end
