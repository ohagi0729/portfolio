class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  has_one_attached :image

  def get_image
    if image.attached?
      image
    else
      default_image_path = Rails.root.join('app/assets/images/no_image.jpg')
      File.open(default_image_path)
    end
  end
end
