class FollowedUser < ApplicationRecord
  belongs_to :user
  belongs_to :to, class_name: 'User', foreign_key: 'to_id'
end
