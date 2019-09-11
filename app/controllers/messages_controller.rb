class MessagesController < ApplicationController
  before_action :set_group,:talk_user 
  
  def index
    @message = Message.new
    @member = Group.find(params[:group_id]).members
    @messages = @group.messages.includes(:user)
    unless @messages.nil?
      @messages.where(checked: false).each do |message|
        message.update_attributes(checked: true)
      end
    end
  end

  def create
    @message = @group.messages.new(message_params)
    if @message.save
        @user_notification = User.find_by(id: Member.where(group_id: @message.group_id).where.not(user_id: current_user.id).pluck(:user_id))
        notification=current_user.active_notifications.new(
          message_id:@message.id,
          visited_id:@user_notification.id,
          group_id:@message.group_id,
          action:"message"
        )
        notification.save if notification.valid?
        respond_to do |format|
          format.html { redirect_to group_messages_path(@group) } 
          format.json
        end
    else
      redirect_to root_path
    end
  end
  
  private
  def message_params
    params.require(:message).permit(:content,:image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
