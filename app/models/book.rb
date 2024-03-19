class Book < ApplicationRecord
  # before_validation :delete_book_if_title_blank
  # before_validation :delete_book_if_introduction_blank
  has_many :book_comments, dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  validates :title, presence:true
  validates :introduction, presence:true, length:{maximum:200}
  # バリデーションを設定すると作成時エラーとなるため作成後に削除する処理
  # def delete_book_if_title_blank
  #   self.mark_for_destruction if title.blank?
  # end
  # 上記の処理をintroductionにも適用
  # def delete_book_if_introduction_blank
  #   self.mark_for_destruction if introduction.blank?
  # end


  # タグ付け
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy
  def save_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags
    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end



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
      Book.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%' + content)
    else
      Book.where('title LIKE ?', '%' + content + '%')
    end
  end
end
