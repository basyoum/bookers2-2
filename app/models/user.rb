class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #ActiveStorageを使ってモデルに画像を持たせる
  has_one_attached :profile_image
  has_many :book, dependent: :destroy

  validates :name, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}

  #画像を表示するためのアクション
  #画像がない時に表示する画像をActiveStorageに格納する
  def get_profile_image(width, height)
    #画像が付属していない？
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/vo_image.jpeg')
      profile_image.attach(io:File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    #メソッドに引数を設定し、引数に設定した値に画像のサイズを変換するようにした
    profile_image.variant(riseze_to_limit:[width, height]).processed
  end
end
