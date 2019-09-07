class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
