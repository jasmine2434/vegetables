class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  
  validates :name, presence: { message: "名前は必須です" }
  validates :email, uniqueness: { message: "このメールアドレスは既に使用されています" }

end
