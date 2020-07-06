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
    @deliveries = current_member.deliveries
  end

  # 注文確認画面
  def confirm
    @cart_items = current_member.cart_items
    @order = Order.new
    # session[:order] = Order.new()
    # session[:order][:pay_type] = params[:pay_type]
    # @pay_type = session[:order]["pay_type"]
    # session[:order] = params[:delivery]
    @pay_type = params[:order][:pay_type]
    case @pay_type
    when 1 then
      @pay = 1
    when 2 then
      @pay = 2
    end
    @derivery = params[:delivery]
    case @derivery
    when 1 then
      @postal_code = current_member.postal_code
      @address = current_member.address
      @name = current_member.last_name + " " + current_member.first_name 
    when 2 then
      delivery = Delivery.find(params[:registered_address])
      @postal_code = delivery.postal_code
      @address = delivery.address
      @name = delivery.name
    when 3 then
      @postal_code = params[:postal_code]
      @address = params[:address]
      @name = params[:delivery_name]
    end
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
      params.require(:order).permit(:pay_type, :delivery_name, :postal_code, :address)
    end
end
