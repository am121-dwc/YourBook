class Book < ApplicationRecord
  has_many :book_comments
  has_many :calendars
  has_many :favorites
  has_many :taggings
  belongs_to :user
  has_one_attached :profile_image
  def get_profile_image()
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
