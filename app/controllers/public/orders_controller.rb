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

  #　注文確認画面
  def confirm
    @cart_items = current_member.cart_items
    @order = current_member.orders.new(order_params)
    # session[:order] = Order.new()
    # session[:order] = order_params
    # session[:order][:delivery_info] = params[:delivery_info]
    # session[:order][:registered_address] = params[:registered_address]
    # @order[:order][:delivery_info] = session[:order]["delivery_info"]
    pay_type = params[:order][:pay_type]
    case @order.pay_type
    when "credit" then
      @pay = "クレジットカード"
    when "bank" then
      @pay = "銀行振込"
    end

    @order.delivery_info = params[:order][:delivery_info]
    case @order.delivery_info 
    when "self_addr" then
      @order.postal_code = current_member.postal_code
      @order.address = current_member.address
      @order.delivery_name = current_member.last_name + " " + current_member.first_name 
    when "registered_addr" then
      delivery = Delivery.find(params[:order][:registered_address])
      @order.postal_code = delivery.postal_code
      @order.address = delivery.address
      @order.delivery_name = delivery.name
    when "new_addr" then
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.delivery_name = params[:order][:delivery_name]
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
      params.require(:order).permit(:member_id, :total_fee, :postage, :pay_type, :delivery_name, :postal_code, :address, :order_status) #:nameを消して:postageを追加でもできた。:nameはいらなかった説。現在ordersテーブルのカラムのみ記述
    end
end
