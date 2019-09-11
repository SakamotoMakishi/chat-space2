module NotificationsHelper

  def unchecked_notifications
    @notifications=current_user.passive_notifications.where(checked: false)
  end

  def notification_form(notification)
    @comment = nil
    @message = nil
    visiter = link_to notification.visiter.nickname, notification.visiter, style:"font-weight: bold;"
    your_post = link_to 'あなたの投稿', notification.post, style:"font-weight: bold;", remote: true
    your_group = link_to 'チャットルーム',"/groups/#{notification.group_id}/messages", style:"font-weight: bold;"
    case notification.action
      when "follow" then
        "#{visiter}があなたをフォローしました"
      when "like" then
        "#{visiter}が#{your_post}にいいね！しました"
      when "comment" then
        @comment = Comment.find_by(id:notification.comment_id)&.comment
        "#{visiter}が#{your_post}にコメントしました"
      when "message" then
        @message = Message.find_by(id:notification.message_id)&.messages
        "#{visiter}から#{your_group}にメッセージが届きました"
    end
    # sbinding.pry
  end
end
