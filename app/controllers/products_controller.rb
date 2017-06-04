class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
      @product = Product.find(params[:id])
      @reviews = @product.reviews
      if @reviews.blank?
          @avg_review = 0
          @avg_look = 0
          @avg_price = 0
        else
          @avg_review = @reviews.average(:freshness).round(2)
          @avg_look = @reviews.average(:look).round(2)
          @avg_price = @reviews.average(:price).round(2)
        end
    end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
    current_cart.add_product_to_cart(@product)
    flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
  else
    flash[:warning] = "你的购物车内已有此物品"
  end
    redirect_to :back
  end
end
