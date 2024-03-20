class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.text :title, null: false
      t.text :introduction, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
