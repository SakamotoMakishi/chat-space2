class PostsController < ApplicationController
  before_action :talk_user, only: [:show,:index]
  before_action :post_show, only: [:show]
  
  def index
    @tags_post_name = params[:tag]
    post_name = params[:tag].present? ? Post.tagged_with(params[:tag]) : Post.all
    @tags_post = post_name.includes(:tags)
  end

  def show
  end

  def create
    @posts = Post.new(post_params)
    if @posts.save
      flash[:notice] = '投稿完了しました'
      redirect_to root_path
    else
      flash[:alert] = '入力してください'
      redirect_to root_path
    end
  end
  
  private
  def post_params
    params.permit(:text,:title,:image,:tag_list).merge(user_id: current_user.id)
  end

  def post_show
    @post = Post.with_attached_image.find(params[:id])
  end
end
