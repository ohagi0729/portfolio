class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  validates :user_id, uniqueness: {scope: :post_id}
end
