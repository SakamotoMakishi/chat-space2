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
end
