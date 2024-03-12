class BookComment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :favorites
  validates :comment, presence: true
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
