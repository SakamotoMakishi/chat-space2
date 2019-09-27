class UsersController < ApplicationController
  before_action :talk_user
  before_action :set_available_tags_to_gon
  require 'date'

  def root
    @post = Post.new
    @followre = current_user.followings
    posts = Post.with_attached_images.where(id:Retweet.includes(:user,:post).where(user_id: @followre.ids << current_user.id).pluck(:post_id)).or(Post.with_attached_images.where(user_id: @followre.ids << current_user.id)).order("updated_at DESC").includes(:user,:likes,:retweets)
    @posts_last =  posts.last
    @posts = posts#.page(params[:page]).per(5)
    cookies.encrypted[:user_id] = @current_user.id
    @online_users = User.with_attached_avatar.where(id: @followre.ids << current_user.id).where.not(online_at: nil).order(online_at: :desc).limit(10)
  end
  
  def index
    user = User.with_attached_avatar.where.not(id: current_user.id)
    @user_last =  user.last
    @user = user.page(params[:page]).per(30)
  end

  def show
    @group = Group.new
    @user = User.with_attached_avatar.find(params[:id])
    @posts = Post.with_attached_images.where(id: @user.posts).or(Post.with_attached_images.where(id: @user.retweets.pluck(:post_id)))
    @ture_user_msg = Group.find_by(name: current_user.nickname, id: Member.where(user_id: @user.id).pluck(:group_id))
  end

  def like_show
    @like_posts = Post.includes(:user,:comments).with_attached_images.where(id: current_user.likes.pluck(:post_id))
  end

  def test
    @post_date_relationship = Relationship.where(follow_id: current_user.id).analytics(:daily)
    @post_date_likes =  Like.where(post_id: current_user.post_ids).analytics(:daily)
    @post_date_retweet = Retweet.where(post_id: current_user.post_ids).analytics(:daily)
    @post_date_comment = Comment.where(post_id: current_user.post_ids).analytics(:daily)
    @post_date = [@post_date_relationship,@post_date_likes,@post_date_retweet,@post_date_comment]
  end

  def test_user_notify
  end

end
