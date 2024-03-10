class Book < ApplicationRecord
  has_many :book_comments
  has_many :calendars
  has_many :favorites
  has_many :taggings
  belongs_to :user
end
