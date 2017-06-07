class AddViewsToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :views, :integer
  end
end
