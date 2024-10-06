class Genre < ApplicationRecord
  has_many :vegetables
  validates :name, presence: true
end
