class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items, source: :product
  before_create :generate_token

  def add_product_to_cart(product)
    ci = cart_items.build
    ci.product = product
    ci.quantity = 1
    ci.save
  end

  def generate_token
    self.token = SecureRandom.uuid
  end

  def total_price
    sum = 0
    cart_items.each do |cart_item|
      if cart_item.product.price.present?
        sum += cart_item.quantity * cart_item.product.price
      end
    end
    sum
  end

  def clean!
    cart_items.destroy_all
  end

  def add(product, quantity)
  # 商品已经在购物车中，增加商品的数量

  if products.include?(product)
    cart_item = cart_items.find_by_product_id(product.id)
  else
    cart_item = cart_items.build
  end
  cart_item.product = product
  cart_item.quantity += quantity
  cart_item.save
end
end
