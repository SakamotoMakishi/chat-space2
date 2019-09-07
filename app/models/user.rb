class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname
    validates :email
    validates :password
    validates :password_confirmation
  end
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
  has_many :like_stories, through: :likes, source: :story

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
end
