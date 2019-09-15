class PostsController < ApplicationController
  before_action :talk_user, only: [:show]
  before_action :post_show, only: [:show]

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
    params.permit(:text,:title,:image).merge(user_id: current_user.id)
  end

  def post_show
    @post = Post.with_attached_image.find(params[:id])
  end
end
