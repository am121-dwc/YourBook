class Favorite < ApplicationRecord
  # 特定の機能には不要なカラムも関連付けされています。注意してください。
  belongs_to :user
  belongs_to :book, optional: true
  belongs_to :book_comment, optional: true
  validates :user_id, uniqueness: {scope: :book_id}
  validates :user_id, uniqueness: {scope: :book_comment_id}
end
