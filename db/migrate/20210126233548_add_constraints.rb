class AddConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column :actions_permissions, :action_id, :bigint, null: false
    change_column :actions_permissions, :permission_id, :bigint, null: false
    add_foreign_key :actions_permissions, :actions
    add_foreign_key :actions_permissions, :permissions

    change_column :permissions_roles, :permission_id, :bigint, null: false
    change_column :permissions_roles, :role_id, :bigint, null: false
    add_foreign_key :permissions_roles, :permissions
    add_foreign_key :permissions_roles, :roles

    execute "UPDATE roles SET description = 'enter a better description' WHERE description IS NULL"
    change_column :roles, :description, :text, null: false
  end
end
