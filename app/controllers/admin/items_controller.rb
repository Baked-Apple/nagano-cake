class Admin::ItemsController < ApplicationController
	before_action :authenticate_admin!

	def index
		@items = Item.all
	end

	def show
		@item = Item.find(params[:id])
		
		
	end

	def new
		@item = Item.new
	end

	def create
<<<<<<< HEAD
			@item = Item.new(item_params)
			if @item.save
					redirect_to admin_item_path(@item.id), notice:'商品を作成しました'
			else
					render 'new'
			end
=======
		@item = Item.new(item_params)
		@item.save!
		redirect_to admin_item_path(@item.id)
>>>>>>> a69c1e63364a20f420c48ab5e009ca18625b8693
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])
		if @item.update(item_params)
				redirect_to admin_item_path(@item.id), notice:'商品情報を更新しました'
		else
			render 'edit'
		end
	end

	private
	def item_params
		params.require(:item).permit(:name, :introduction, :genre_id, :price, :image, :sale_status)
	end
end
