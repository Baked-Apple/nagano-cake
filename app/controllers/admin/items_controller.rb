class Admin::ItemsController < ApplicationController
	
	def index
	end

	def show
		@item = @item.find(params[:id])
	end

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(item_params)
		@item.genre_id = Genre.id
		@item.save
		redirect_to(@item.id)
	end

	def edit
	end

	def update
	end

	private
	def item_params
		params.require(:item).permit(:name, :introduction, :price, :image, :sale_status)
	end
end
