class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      #いいねしたユーザのid
      t.integer :user_id
      #いいねされた投稿のid
      t.integer :book_id

      t.timestamps
    end
  end
end
