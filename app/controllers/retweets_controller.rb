class RetweetsController < ApplicationController
  before_action :set_retweet_variables

  def index
  end

  def retweet
    retweet = current_user.retweets.new(post_id: @post.id)
    if retweet.save!
        @post.touch
        @post.retweet_create_notification_by(current_user) if @post.user_id != current_user.id
        flash[:notice] = '投稿をリツイートしました'
        redirect_to request.referrer
    end  
  end

  def unretweet
    retweet = current_user.retweets.find_by(post_id: @post.id)
    retweet.destroy!
    @post.retweet_delete_notification_by(current_user)
  end

  private

  def set_retweet_variables
    @post = Post.find(params[:post_id])
    @id_name = "#retweet-link-#{@post.id}"
  end
end
