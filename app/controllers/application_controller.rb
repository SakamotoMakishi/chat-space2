class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_available_tags_to_gon

  def after_sign_in_path_for(resource)
    if current_user.email == "test_user@test.com"
      flash[:notice] = "テストユーザーとしてログインしました" 
      test_user_notify_users_path
    else
      flash[:notice] = "ログインしました" 
      root_path
    end
  end

  def set_available_tags_to_gon
    gon.available_tags = Post.tags_on(:tags).pluck(:name)
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
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname,:avatar,:profile])
  end
end
