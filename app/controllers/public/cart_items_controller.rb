class Public::CartItemsController < ApplicationController
	def index
		@cart_item = CartItem.new
		@cart_items = CartItem.all
	end

	def create
		cart_item = CartItem.new()
		cart_item.save
		redirect_to public_cart_items_path
	end

	def update
	end

	def destroy
		cart_item = CartItem.find(params[:id])
		cart_item.destroy
		redirect_to public_cart_items_path
	end
end
