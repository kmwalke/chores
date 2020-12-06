class AddControllerToPermissions < ActiveRecord::Migration[6.0]
  def change
    add_column :permissions, :feature_id, :string
  end
end
