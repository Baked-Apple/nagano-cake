class Public::CartItemsController < ApplicationController
	def index
		@item = Item.find(params[:item_id])
		@cart_item = CartItem.new
		@cart_items = CartItem.all
	end

	def create
		@item = Item.find(params[:item_id])
		@cart_item = current_member.cart_items.new(cart_item_params)
		@cart_item.item_id = @item.id
		@cart_item.save
		redirect_to public_item_cart_items_path
	end

	def update
		@item = Item.find(params[:item_id])
		@item.update(item_params)
		redirect_to public_item_cart_items_path(cart_item.item)
	end

	def destroy
		@cart_items = CartItem.all
		cart_item = CartItem.find(params[:id])
		cart_item.destroy
		redirect_to public_item_cart_items_path(cart_item)
	end

	private
	def cart_item_params
		params.require(:cart_item).permit(:member_id, :item_id, :quantity)
	end
	def item_params
		params.require(:item).permit(:quantity)
	end
end
