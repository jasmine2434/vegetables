class Vegetable < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, :body, presence: true

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

  def self.search_for(content, method)
    if method == 'perfect'
      Vegetable.where(name: content)
    else
      Vegetable.where('name LIKE ?', '%' + content + '%')
    end
  end
end
