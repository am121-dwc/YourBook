class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :books, through: :taggings
  
  validates :name, presence:true, length: {maximum:20}
end
