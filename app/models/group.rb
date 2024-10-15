class Group < ApplicationRecord

  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :group_users
  belongs_to :vegetable

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image

  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/default_group.png')
       group_image.attach(io: File.open(file_path), filename: 'default-g.png', content_type: 'image/png')
    end
      group_image.variant(resize_to_limit: [width, height]).processed
  end

  def is_owned_by?(user)
    owner.id == user.id
  end

end
