class AddPaymentMethodToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :payment_method, :string
    add_column :carts, :payment_method, :string
  end
end
