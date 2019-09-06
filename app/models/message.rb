class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_one_attached :image
  validates :content, presence: true, unless: :image
end
