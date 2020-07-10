class Public::CartItemsController < ApplicationController
	def index
		@member = Member.find(current_member.id)

	end

	def create
		@cart_item = current_member.cart_items.new(cart_item_params)
     	@cart_item.save
      	redirect_to public_cart_items_path
    end

	

	def update
    	@cart_item = CartItem.find(params[:id])
    @cart_item.update!(cart_item_params)
    flash[:notice] = "カート内の商品情報を更新しました。"
    @member = Member.find(current_member.id)
    render :index
	end

	def destroy
		 cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      flash[:notice] = "カート内の商品を削除しました。"
      redirect_to public_cart_items_path
    else
      render action: :index
    end
	end

	def destroy_all
    member = Member.find(current_member.id)
    if member.cart_items.destroy_all
      flash[:notice] = "カート内の商品を全て削除しました。"
      redirect_to public_cart_items_path
    else
      render action: :index
    end
  end

	


	private

	def cart_item_params
		params.require(:cart_item).permit(:quantity, :item_id)
	end

end
