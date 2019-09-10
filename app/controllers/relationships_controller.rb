class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    user = User.find(params[:relationship][:follow_id])
    following = current_user.follow(user)
    if following.save
      flash[:notice] = 'ユーザーをフォローしました'
      redirect_to root_path
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      edirect_to root_path
    end
  end

  def destroy
    user = User.find(params[:relationship][:follow_id])
    following = current_user.unfollow(user)
    if following.destroy
      flash[:notice] = 'ユーザーをフォローしました'
      edirect_to root_path
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      edirect_to root_path
    end
  end

  private

  def set_user
    user = User.find(params[:relationship][:follow_id])
  end
end
