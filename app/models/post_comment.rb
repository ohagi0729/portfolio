class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post

  #登録日が最新の会員が上に来るようにする指示
  default_scope -> { order(created_at: :desc) }
end
