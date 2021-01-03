class AddSoftDeletes < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deleted_at, :datetime
    add_column :rewards, :deleted_at, :datetime
  end
end
