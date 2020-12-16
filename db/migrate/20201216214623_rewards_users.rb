class RewardsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards_users, id: false do |t|
      t.belongs_to :reward
      t.belongs_to :user
      t.datetime :created_at
    end
  end
end
