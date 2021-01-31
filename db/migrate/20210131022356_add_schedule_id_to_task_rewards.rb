class AddScheduleIdToTaskRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :schedule_id, :integer, comment: 'null means repeat forever'
    add_column :rewards, :schedule_id, :integer, comment: 'null means repeat forever'
  end
end
