class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @order = Order.new
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save

      current_cart.cart_items.each do |cart_item|
        product_list = ProductList.new
        product_list.order = @order
        product_list.product_name = cart_item.product.title
        product_list.product_price = cart_item.product.price
        product_list.quantity = cart_item.quantity
        product_list.save
      end
      current_cart.clean!
      OrderMailer.notify_order_placed(@order).deliver!

      redirect_to order_path(@order.token)
    else
      render 'carts/checkout'
    end
  end

  def order_create
    product = Product.find(params[:product_id])
    order = Order.new
    order.user = current_user
    order.total = product.price

    if order.save

      product_list = ProductList.new
      product_list.order_id = order.id
      product_list.product_name = product.title
      product_list.product_price = product.price
      product_list.quantity = 1
      poduct_list.save
    end


    redirect_to order_path(id: order.id), notice: "订单已生成，请尽快付款。。。"
  end

  def show

    @order = Order.find_by_token(params[:id])
    @product_lists = @order.product_lists
  end

  def pay_with_alipay
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!("alipay")
    @order.make_payment!

    redirect_to order_path(@order.token), notice: "使用支付宝成功完成付款"
  end

  def pay_with_wechat
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!("wechat")
    @order.make_payment!

    redirect_to order_path(@order.token), notice: "使用微信成功完成付款"
  end

  def apply_to_cancel
    @order = Order.find(params[:id])
    OrderMailer.apply_cancel(@order).deliver!
    flash[:notice] = "已提交申请"
    redirect_to :back
  end


end
