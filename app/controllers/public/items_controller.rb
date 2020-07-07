class Public::ItemsController < ApplicationController
	def index
    if params[:genre_id].present?
      @item = Item.where(genre_id: params[:genre_id])
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
    	@cart_item = CartItem.new(item_id: @item.id)
    	@genres = Genre.all
		
	end

	

	
end

