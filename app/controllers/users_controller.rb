class UsersController < ApplicationController
  before_action :talk_user 

  def root
    @followre = current_user.followings
    @posts = Post.with_attached_image.where(id:Retweet.where(user_id: @followre.ids << current_user.id).pluck(:post_id)).or(Post.with_attached_image.where(user_id: @followre.ids << current_user.id)).order("updated_at DESC")
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
