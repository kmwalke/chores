class DropColsFromPermissions < ActiveRecord::Migration[6.0]
  def change
    remove_column :permissions, :name, :string
    remove_column :permissions, :description, :text
  end
end
