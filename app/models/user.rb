class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable

  has_many :answers, dependent: :destroy
  has_many :followed_questions, dependent: :destroy
  has_many :followed_users
  has_many :followers, class_name: 'FollowedUser', foreign_key: 'to_id'
  has_many :questions, dependent: :destroy
end
