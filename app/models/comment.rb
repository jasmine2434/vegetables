class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :vegetable

  validates :body, presence: true

  def self.search_for(content, method)
    if method == 'perfect'
      Comment.where(body: content)
    else
      Comment.where('body LIKE ?', '%' + content + '%')
    end
  end

end
