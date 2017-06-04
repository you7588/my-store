class AddStarDetailsToReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :experience, :integer
    add_column :reviews, :production, :integer
    add_column :reviews, :photography, :integer
  end
end
