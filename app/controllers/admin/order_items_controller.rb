class Admin::OrderItemsController < ApplicationController

	def update
		@order_item = OrderItems.find(params[:id])
		if @order_item.update(order_item_params)
			# 製作状況が２＝製作中になったら、注文ステータスを製作中２に
		 	if @product_status == 2
		 		@order.update(order_status: 2)
		 	# 製作状況が３＝製作完了になったら、注文ステータスを発送準備中３に
		 	elsif @product_status == 3
		 		@order_item.update(order_status: 3)
		 	end
		 	redirect_to admin_order_path(@order.id)
		end
    end

    def order_item_params
    	params.require(:order_item).permit(:price, :quantity, :product_status)
	end

end
