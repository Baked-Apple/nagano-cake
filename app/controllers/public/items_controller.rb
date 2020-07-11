class Public::ItemsController < ApplicationController
	def index
    if params[:genre_id].present?
      @items = Item.where(genre_id: params[:genre_id])
      .page(params[:page]).per(16).reverse_order

      @item_genre = @items.first.genre if @items.count > 0
    else
      # ジャンルが無効になっている商品は一覧に表示しない
      @items = Item
        .joins(:genre).where(genres: {invalid_status: 0})
        .page(params[:page]).per(16).reverse_order
    end
    @genres = Genre.all
  end

  def search
    #
    @q_items = @q.result.page(params[:page]).per(16).reverse_order
    @genres = Genre.all

    render :index
  end

	def show
		@item = Item.find(params[:id])
<<<<<<< HEAD
    	@cart_item = CartItem.new(item_id: @item.id)
    	@genres = Genre.all
		
=======
		@cart_item = CartItem.new
>>>>>>> a69c1e63364a20f420c48ab5e009ca18625b8693
	end

	

	
end

