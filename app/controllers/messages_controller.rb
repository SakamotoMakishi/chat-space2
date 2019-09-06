class MessagesController < ApplicationController
  before_action :set_group
  
  def create
    @message = @group.messages.new(message_params)
    @message.save
  end
  
  private
  def message_params
    params.require(:message).permit(:content,:image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
