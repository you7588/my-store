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


end
