class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  #フォローする
  def create
    user = User.find(params[:user_id])
    #userモデルで作成したアクション
    current_user.follow(user)
    redirect_to request.referer
  end

  #フォロー外す
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  #フォロワー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  #フォロー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
