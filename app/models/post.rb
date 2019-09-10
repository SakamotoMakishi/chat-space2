class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments,foreign_key: :post_id, dependent: :destroy
  validates :posts, presence: true

  def posts
    text.presence || image.attached? || title.presence
  end
end
