class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :profile_image
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :image, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def get_profile_image
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("caption LIKE?","#{word}")
    elsif search == "partial_match"
      @post = Post.where("caption LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

  #登録日が最新の投稿が左上に来るようにする指示
  default_scope -> { order(created_at: :desc) }
end
