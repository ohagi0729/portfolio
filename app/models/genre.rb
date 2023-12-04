class Genre < ApplicationRecord
  has_many :post
  validates :name, presence: true, uniqueness: true
end
