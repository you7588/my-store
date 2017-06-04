class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :body, presence: true

  scope :recent, -> { order("created_at DESC")}
end
