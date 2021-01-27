class AddConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column :actions_permissions, :action_id, :bigint, null: false
    change_column :actions_permissions, :permission_id, :bigint, null: false
    add_foreign_key :actions_permissions, :actions
    add_foreign_key :actions_permissions, :permissions
    add_index :actions_permissions, [:action_id, :permission_id], unique: true

    change_column :permissions_roles, :permission_id, :bigint, null: false
    change_column :permissions_roles, :role_id, :bigint, null: false
    add_foreign_key :permissions_roles, :permissions
    add_foreign_key :permissions_roles, :roles
    add_index :permissions_roles, [:permission_id, :role_id], unique: true

    change_column :rewards_users, :reward_id, :bigint, null: false
    change_column :rewards_users, :user_id, :bigint, null: false
    change_column :rewards_users, :created_at, :datetime, null: false
    add_foreign_key :rewards_users, :rewards
    add_foreign_key :rewards_users, :users
    add_index :rewards_users, [:reward_id, :user_id], unique: true

    execute "UPDATE roles SET description = 'enter a better description' WHERE description IS NULL"
    change_column :roles, :description, :text, null: false

    change_column :task_instances, :created_on, :date, null: false

    change_column :users, :role_id, :integer, null: false
  end
end
