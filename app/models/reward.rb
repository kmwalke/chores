class Reward < ApplicationRecord
  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to :user

  before_save :abbreviate
  after_save :set_user_reward

  def abbreviate
    update(abbreviation: name[0..1]) if abbreviation != name[0..1]
  end

  def set_user_reward
    return unless user.rewards.count == 1

    user.update(next_reward_id: id)
  end
end
