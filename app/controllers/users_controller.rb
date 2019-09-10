class UsersController < ApplicationController

  def root
    @talk_user = User.with_attached_avatar.where(id: Member.where(group_id: current_user.groups.ids).where.not(user_id: current_user.id).pluck(:user_id))
    @followre = current_user.followings
    @posts = Post.with_attached_image.where(user_id: @followre.ids << current_user.id).order("created_at DESC")
  end

  def index
    @user = User.with_attached_avatar.where.not(id: current_user.id)
  end

  def show
    @group = Group.new
    @user = User.with_attached_avatar.find(params[:id])
    @posts = @user.posts.with_attached_image
  end

end
