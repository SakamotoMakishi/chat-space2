class PostsController < ApplicationController
  before_action :talk_user, only: [:show,:index,:edit]
  before_action :post_show, only: [:show,:edit,:update,:destroy]
  
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

  def edit
    gon.post_tags = @post.tag_list
    if @post.user_id != current_user.id
      flash[:notice] = '無効なリンクです。'
      redirect_to root_path
    end
  end

  def update
    if @post.user_id == current_user.id
      if @post.update(post_params)
        flash[:notice] = '投稿を編集しました'
        redirect_to root_path
      else
        flash[:alert] = '入力してください'
        redirect_to root_path
      end
    else
      redirect_to action: :edit
    end
  end

  def destroy
    if @post.user_id == current_user.id
      if @post.destroy
        flash[:notice] = '投稿を削除しました。'
        redirect_to root_path
      else
        flash[:alert] = '投稿削除失敗しました。'
        redirect_to action: :edit
      end
    else
      redirect_to action: :edit
    end
  end
  
  private
  def post_params
    params.permit(:text,:title,:image,:tag_list).merge(user_id: current_user.id)
  end

  def post_show
    @post = Post.with_attached_image.find(params[:id])
    @like_user = @post.liking_users
    @retweet_user = @post.retweets_users
  end

end
