class Book < ApplicationRecord
  has_many :book_comments, dependent: :destroy
  has_many :calendars
  has_many :favorites
  has_many :taggings
  belongs_to :user
  has_one_attached :profile_image
  def get_profile_image()
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  # 検索方法
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('name LIKE ?', '%' + content)
    else
      Book.where('name LIKE ?', '%' + content + '%')
    end
  end
end
