class MessagesController < ApplicationController
  def create
    @message = Post.create(message_params)
  end
  
  private
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
