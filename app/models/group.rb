class Group < ApplicationRecord
  has_many :members
  has_many :users, through: :members
  has_many :messages
end
