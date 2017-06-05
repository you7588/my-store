class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
      @product = Product.find(params[:id])
      @reviews = @product.reviews.recent.paginate(:page => params[:page], :per_page => 5)
      if @reviews.blank?
          @avg_experience = 0
          @avg_production = 0
          @avg_photography = 0
        else
          @avg_experience = @reviews.average(:experience).round(2)
          @avg_production = @reviews.average(:production).round(2)
          @avg_photography = @reviews.average(:photography).round(2)
        end
    end

    def add_to_cart
  @product = Product.find(params[:id])
  @quantity = params[:quantity].to_i
  # 判断加入购物车的商品是否超过库存

  if @quantity > @product.quantity
    @quantity = @product.quantity
    flash[:warning] = "您选择的商品数量超过库存，实际加入购物车的商品为#{@quantity}件。"
  else
    current_cart.add(@product, @quantity)
  end
  redirect_to product_path(@product)
end
end
