class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:avatar])
  end
  
  def talk_user
    @talk_user = User.includes(:messages,:groups,:members).with_attached_avatar.where(id: Member.includes(:user,:group,).where(group_id: current_user.groups.ids).where.not(user_id: current_user.id).pluck(:user_id)).order("updated_at DESC")
  end

  def show_last_message
    if (last_message = messages.last).present?
      if last_message.content?
        last_message.content
      else
        '画像が投稿されています'
      end
    else
      'まだメッセージはありません。'
    end
  end
end
