class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :profile,    length: { maximum: 120 }
  has_one_attached :avatar
  has_many :members
  has_many :groups, through: :members
  has_many :messages
  has_many :posts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow #フォローしているユーザー達
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'#フォローされているユーザー達フォロワー
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :likes, dependent: :destroy
  has_many :like_stories, through: :likes, source: :post
  has_many :retweets, dependent: :destroy
  has_many :retweets_posts, through: :retweets, source: :post
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def follow_create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      visited_id:self.id,
      action:"follow"
    )
    notification.save if notification.valid?
  end

  def follow_delete_notification_by(current_user)
    notification=current_user.active_notifications.find_by(
      visited_id:self.id,
      action:"follow"
    )
    notification.destroy if !notification.nil?
  end

  after_update_commit :watchonline_self

  def watchonline_self
    if saved_change_to_online?
      AppearanceBroadcastJob.perform_later(self)
    end
  end
end
