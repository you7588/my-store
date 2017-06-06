class CartsController < ApplicationController
  def clean
    current_cart.clean!
    flash[:warning] = "已清空购物车"
    redirect_to carts_path
  end

  def checkout
    @order = Order.new
  end

  def show
    @cart = Cart.find(params[:id])
    # @cart = Cart.find_by_token(params[:id])
  end
  
  def pay_with_alipay
    # @cart = Cart.find_by_token(params[:id])
    @cart = Cart.find(params[:id])
    @cart.set_payment_with!("alipay")
    @cart.pay!

    # redirect_to cart_path(@cart.token), notice: "使用支付宝成功完成付款"
    redirect_to cart_path(@cart), notice: "使用支付宝成功完成付款"
  end

  def pay_with_wechat
    # @cart = Cart.find_by_token(params[:id])
    @cart = Cart.find(params[:id])
    @cart.set_payment_with!("wechat")
    @cart.pay!

    # redirect_to cart_path(@cart.token), notice: "使用微信成功完成付款"
    redirect_to cart_path(@cart), notice: "使用微信成功完成付款"
  end


end
