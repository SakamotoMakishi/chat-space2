module NotificationsHelper

  def unchecked_notifications
    @notifications=current_user.passive_notifications.where(checked: false)
  end

  def notification_form(notification)
    @comment=nil
    visiter=link_to notification.visiter.nickname, notification.visiter, style:"font-weight: bold;"
    your_post=link_to 'あなたの投稿', notification.post, style:"font-weight: bold;", remote: true
    case notification.action
      when "follow" then
        "#{visiter}があなたをフォローしました"
      when "like" then
        "#{visiter}が#{your_post}にいいね！しました"
      when "comment" then
        @comment=Comment.find_by(id:notification.comment_id)&.content
        "#{visiter}が#{your_post}にコメントしました"
    end
  end
end
