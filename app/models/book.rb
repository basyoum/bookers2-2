class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}

  #ログイン中のユーザがその投稿に対していいねしているかを判断するメソッド
  #任意のアクション名(引数)、ビューでcurrent_user(ログインしているユーザ)を指定する
  def favorited_by?(user)
    #favoriteテーブルに、引数(current_user)のidと等しいuser_idを持つレコードは存在するか?
    favorites.where(user_id: user.id).exists?
  end
  #一致するレコードがある = createアクションへ
  #一致するレコードがない = destroyアクションへの分岐をさせることができる
end
