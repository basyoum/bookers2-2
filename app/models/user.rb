class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #ActiveStorageを使ってモデルに画像を持たせる
  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  #いいね機能
  has_many :favorites, dependent: :destroy
  #コメント機能
  has_many :book_comments, dependent: :destroy

  #フォロー・フォロワー機能
  #自分がフォローされる（被フォロー）側の関係性
  #任意のテーブル名(reverse_of_relationship)、参照するテーブル、参照するカラム(フォローされる人のid)
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  #被フォロー関係を通じて参照→自分をフォローしている人
  #任意のテーブル名(followers)、スルーするテーブル、参照するカラム(relationshipモデルより)
  has_many :followers, through: :reverse_of_relationships, source: :follower

  #自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  #与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  #フォローする処理
  #フォローする人のid
  def follow(user)
    #フォローされる人のid
    relationships.create(followed_id: user.id)
  end

  #フォロー外す処理
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  #フォローしているかを判定
  def following?(user)
    followings.include?(user)
  end

  #検索機能、検索分岐条件
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where(' name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where(' name LIKE ? ', '%' + content)
    else
      User.where(' name LIKE ?', '%' + content + '%')
    end
  end


  validates :name, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}

  #画像を表示するためのアクション
  #画像がない時に表示する画像をActiveStorageに格納する
  def get_profile_image(width,height)
    #画像が付属していない？
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    #(profile_image.attached?) ? profile_image : 'no_image.jpg'
    #メソッドに引数を設定し、引数に設定した値に画像のサイズを変換するようにした
    profile_image.variant(resize_to_limit: [width,height]).processed
  end
end
