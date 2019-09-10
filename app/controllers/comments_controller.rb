class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path } 
        format.json
      end
    else
      redirect_to root_path
    end
  end
  private
  def comment_params
    params.permit(:comment, :post_id).merge(user_id: current_user.id)
  end
end