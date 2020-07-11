class Public::OrdersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_cart_items, only: [:confirm, :create]
  before_action :set_order, only: [:confirm, :create]
  
  # 注文履歴一覧画面
  def index
    @orders = current_member.orders
  end

  # 注文履歴詳細画面
  def show
    @order = Order.find(params[:id])
    case @order.pay_type
    when "credit" then
      @pay = "クレジットカード"
    when "bank" then
      @pay = "銀行振込"
    end
  end

  # 注文入力画面
  def new
    @order = Order.new
    @deliveries = current_member.deliveries
  end

  #　注文確認画面
  def confirm
    @order.postage = 800
    @order.total_fee = current_member.cart_item_sum + @order.postage #請求金額 = カート内商品合計金額 + 送料

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
    if @cart_items.empty?
      flash[:notice] = "購入する商品がありません"
      redirect_to public_items_path
    else
      if @order.save #@order.saveがtrueの時、以下実行
        @cart_items.each do |cart_item|
          @order.order_items.create( #@orderに紐づくorder_itemsテーブルのデータを作成
            order_id: @order.id,
            item_id: cart_item.item_id,
            price: cart_item.item.price_with_tax,
            quantity: cart_item.quantity,
            product_status: 0
          )
        end
        if params[:delivery_info] == "new_addr" #params[:delivery_info] = "new_addr"がtrueの時、以下実行
          current_member.deliveries.create( #current_memberに紐づくdeliveriesテーブルのデータを作成
            postal_code: @order.postal_code,
            address: @order.address,
            name: @order.delivery_name
          )
        end
        current_member.cart_items.destroy_all #カート内商品を全て削除
        redirect_to public_orders_thanks_path
      else
        flash[:notice] = "登録に失敗しました"
        redirect_to public_orders_new_path
      end
    end
  end

  # 注文完了(サンクス)
  def thanks
  end

    private
    def set_cart_items
      @cart_items = current_member.cart_items
    end

    def set_order
      @order = current_member.orders.build(order_params)
    end

    def order_params
      params.require(:order).permit(:total_fee, :postage, :pay_type, :postal_code, :address, :delivery_name, :order_status)
    end
end
