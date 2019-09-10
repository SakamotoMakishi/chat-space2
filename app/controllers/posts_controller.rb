class PostsController < ApplicationController

  def create
    @posts = Post.new(post_params)
    if @posts.save
      flash[:notice] = '投稿完了しました'
      redirect_to root_path
    else
      flash[:alert] = 'いずれか入力してください'
      redirect_to root_path
  end
  end
  
  private
  def post_params
    params.permit(:text,:title,:image).merge(user_id: current_user.id)
  end
end
