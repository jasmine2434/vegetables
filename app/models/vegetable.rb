class Vegetable < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :body, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/vegetable.png')
       image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
