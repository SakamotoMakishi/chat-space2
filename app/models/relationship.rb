class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  validates :user_id, presence: true
  validates :follow_id, presence: true

  def follow_create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      visited_id:self.id,
      action:"follow"
    )
    notification.save if notification.valid?
  end

  def delete_notification_by(current_user)
    notification=current_user.active_notifications.find_by(
      visited_id:self.id,
      action:"follow"
    )
    notification.destroy if !notification.nil?
  end
end
