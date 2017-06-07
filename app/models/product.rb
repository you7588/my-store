class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :reviews

  def increment(by = 1)
    self.views ||= 0
    self.views += by
    self.save
  end

end
