class Relationship < ApplicationRecord
  #フォロー・フォロワー共にuserモデルからidを取得するため
  #user_idではなく任意のカラムにする
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
end
