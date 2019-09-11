class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_one_attached :image
  validates :messages, presence: true

  def messages
    content.presence || image.attached?
  end

  def message_create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      message_id:self.id,
      visited_id:self.group.user.id,
      group_id:self.group.id,
      action:"message"
    )
    notification.save if notification.valid?
    bin
  end

  def message_delete_notification_by(current_user)
    notification=current_user.active_notifications.find_by(
      message_id:self.id,
      visited_id:self.group.users.ids,
      action:"message"
    )
    notification.destroy if !notification.nil?
  end
end
