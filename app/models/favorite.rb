class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :vegetable
  
  validates :user_id, uniqueness: {scope: :vegetable_id}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
