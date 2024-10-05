class Vegetable < ApplicationRecord
  
  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  validates :vege_name, presence: true
  validates :body, presence: true
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
       profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
