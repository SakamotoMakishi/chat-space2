class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_one_attached :image
  validates :messages, presence: true
  def messages
    content.presence || image.attached?
  end
end
