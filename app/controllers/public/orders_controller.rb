class Public::OrdersController < ApplicationController
  # 注文履歴一覧画面
  def index
    @orders = Order.all
  end

  # 注文履歴詳細画面
  def show
    @orders = Order.all
    @order = Order.find(params[:id])
  end

  # 注文入力画面
  def new
    @order = Order.new
  end

  # 注文確認画面
  def confirm
    @cart_items = CartItem.all
    @order = Order.new
    return if @order.valid?
    render :new
  end

  # 注文確定・保存
  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to public_orders_thanks_path
  end

  # 注文完了(サンクス)
  def thanks
  end

  private
    def order_params
      params.require(:order).permit(:pay_type, :postal_code, :address, :delivery_name)
    end
end
