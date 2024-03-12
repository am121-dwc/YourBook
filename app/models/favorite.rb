class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :book_comment
  validates :user_id, uniqueness: {scope: :book_id}
  validates :user_id, uniqueness: {scope: :book_comment_id}
end
