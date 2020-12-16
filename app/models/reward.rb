class Reward < ApplicationRecord
  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to :user
end
