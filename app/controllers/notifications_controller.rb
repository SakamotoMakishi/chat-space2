class NotificationsController < ApplicationController
  before_action :talk_user 

  def index
    notifications = current_user.passive_notifications
    @notifications_last = notifications.last
    @notifications = current_user.passive_notifications.page(params[:page]).per(6)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
