class Post < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  has_many_attached :images
  has_many :retweets, dependent: :destroy
  has_many :retweets_users, through: :retweets, source: :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments,foreign_key: :post_id, dependent: :destroy
  has_many :notifications,dependent: :destroy
  validates :posts, presence: true
  validates :images, length: { maximum: 5}
    

  def posts
    text.presence || images.attached? 
  end

  def create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      post_id:self.id,
      visited_id:self.user.id,
      action:"like"
    )
    notification.save if notification.valid?
  end

  def delete_notification_by(current_user)
    notification=current_user.active_notifications.find_by(
      post_id:self.id,
      visited_id:self.user.id,
      action:"like"
    )
    notification.destroy if !notification.nil?
  end

  def retweet_create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      post_id:self.id,
      visited_id:self.user.id,
      action:"retweet"
    )
    notification.save if notification.valid?
  end

  def retweet_delete_notification_by(current_user)
    notification=current_user.active_notifications.find_by(
      post_id:self.id,
      visited_id:self.user.id,
      action:"retweet"
    )
    notification.destroy if !notification.nil?
  end
end
