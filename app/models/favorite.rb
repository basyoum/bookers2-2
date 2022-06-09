class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates_uniqueness_of :book_id, scope: :user_id
  #validates_uniqueness_of(フィールド名..) = 属性の値が一意であることをバリデーション(確認)
  #:scope(オプション) = 一意性制約を決めるために使用する他のカラム
  #一意 = 重複してない、オンリーワン

end
