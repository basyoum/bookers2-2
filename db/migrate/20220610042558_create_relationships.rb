class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      #フォローする
      t.integer :follower_id
      #フォローされる
      t.integer :followed_id

      t.timestamps
    end
  end
end
