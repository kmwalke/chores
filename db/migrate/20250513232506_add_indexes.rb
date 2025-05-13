class AddIndexes < ActiveRecord::Migration[8.0]
  def change
    add_index :actions, :name, unique: true
    add_index :features, :name, unique: true
    add_index :roles, :name, unique: true
    add_index :users, :email, unique: true
  end
end
