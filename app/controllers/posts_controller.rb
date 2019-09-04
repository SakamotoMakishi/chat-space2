class PostsController < ApplicationController

  def create
    @posts = Post.create(post_params)
  end
  
  private
  def post_params
    params.permit(:text,:title).merge(user_id: current_user.id)
  end
end
