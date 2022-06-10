class Book < ApplicationRecord
  belongs_to :user
  #いいね機能
  has_many :favorites, dependent: :destroy
  #コメント機能
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}

  #ログイン中のユーザがその投稿に対していいねしているかを判断するメソッド
  #任意のアクション名(引数)、ビューでcurrent_user(ログインしているユーザ)を指定する
  def favorited_by?(user)
    #favoriteテーブルに、引数(current_user)のidと等しいuser_idを持つレコードは存在するか?
    favorites.where(user_id: user.id).exists?
  #一致するレコードがある = createアクションへ
  #一致するレコードがない = destroyアクションへの分岐をさせることができる
  end

  #検索機能、検索分岐条件
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where(' title LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where(' title LIKE ? ', '%' + content)
    else
      Book.where(' title LIKE ?', '%' + content + '%')
    end
  end

end
