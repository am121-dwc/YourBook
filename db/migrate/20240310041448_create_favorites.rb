class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.references :book_comment, null: false, foreign_key: true
      # t.bigint :book_id, null: true
      t.timestamps
    end
  end
end
