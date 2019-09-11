class Comment < ApplicationRecord
  belongs_to :post,optional: true
  belongs_to :user,optional: true
  validates :comment, presence: true

  def comment_create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      comment_id:self.id,
      visited_id:self.post.user.id,
      post_id:self.post.id,
      action:"comment"
    )
    notification.save if notification.valid?
  end

  def comment_delete_notification_by(current_user)
    notification=current_user.active_notifications.find_by(
      comment_id:self.id,
      visited_id:self.post.user.id,
      action:"comment"
    )
    notification.destroy if !notification.nil?
  end
end
