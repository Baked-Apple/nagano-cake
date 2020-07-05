class Public::ItemsController < ApplicationController
	def index
		@items = Item.all
	end

	def show
		@item = Item.find(params[:id])
		@cart_item = current_user.cart_items
	end

	def create
		
	end

	private
		def item_params
			params.require(:item).permit(:name, :introduction, :price, :image_id, :sale_status)
		end
	end

