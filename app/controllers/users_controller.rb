class UsersController < ApplicationController
  before_action :talk_user
  before_action :set_available_tags_to_gon
  require 'date'

  def root
    @followre = current_user.followings
    @posts = Post.with_attached_image.where(id:Retweet.includes(:user,:post).where(user_id: @followre.ids << current_user.id).pluck(:post_id)).or(Post.with_attached_image.where(user_id: @followre.ids << current_user.id)).order("updated_at DESC").includes(:user,:likes,:retweets)
    cookies.encrypted[:user_id] = @current_user.id
    @online_users = User.with_attached_avatar.where(id: @followre.ids << current_user.id).where.not(online_at: nil).order(online_at: :desc)
  end
  
  def index
    @user = User.with_attached_avatar.where.not(id: current_user.id).limit(30)
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

  def test
    cookies.encrypted[:user_id] = @current_user.id
    @online_users = User.where.not(online_at: nil).order(online_at: :desc)
  end

  def test_user_notify
  end

end
