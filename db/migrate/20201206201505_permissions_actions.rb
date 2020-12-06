class PermissionsActions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions_actions, id: false do |t|
      t.belongs_to :permission
      t.belongs_to :action
    end
  end
end
