class AddNextRewardToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :next_reward_id, :integer
  end
end
