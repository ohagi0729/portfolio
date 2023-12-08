class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  #　フォローした、された時の関係
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使う
  has_many :following_customer, through: :followers, source: :followed
  has_many :follower_customer, through: :followeds, source: :follower
  #　フォローしたときの処理
  def follow(customer_id)
    followers.create(followed_id: customer_id)
  end
  #　フォローを外すときの処理
  def unfollow(customer_id)
    followers.find_by(followed_id: customer_id).destroy
  end
  #フォローしていればtrueを返す
  def following?(customer)
    following_customers.include?(customer)
  end

  enum is_active: {active: true, non_active: false}

  def get_profile_image
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @customer = Customer.where("name LIKE?","%#{word}%")
    else
      @customer = Customer.all
    end
  end

end
