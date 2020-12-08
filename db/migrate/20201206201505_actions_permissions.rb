class ActionsPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :actions_permissions, id: false do |t|
      t.belongs_to :permission
      t.belongs_to :action
    end
  end
end
