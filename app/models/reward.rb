class Reward < ApplicationRecord
  include SoftDeletable

  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to :user

  after_save :set_user_reward

  def avatar
    abbreviation
  end

  def abbreviation
    name[0..1]
  end

  def set_user_reward
    return unless user.rewards.count == 1

    user.update(next_reward_id: id)
  end
end
