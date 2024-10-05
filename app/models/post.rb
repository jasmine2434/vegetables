class Post < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  validates :vege_name, presence: true
  validates :body, presence: true
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
