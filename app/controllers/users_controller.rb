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
    @posts = Post.with_attached_image.where(id: @user.posts).or(Post.with_attached_image.where(id: @user.retweets.pluck(:post_id)))
    @ture_user_msg = Group.find_by(name: current_user.nickname, id: Member.where(user_id: @user.id).pluck(:group_id))
  end

  def like_show
    @like_posts = Post.with_attached_image.where(id: current_user.likes.pluck(:post_id))
  end

end
