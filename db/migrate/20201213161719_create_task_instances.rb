class CreateTaskInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :task_instances do |t|
      t.integer :task_id, null: false
      t.boolean :completed?, default: false, null: false
      t.datetime :completed_at
      t.date :created_on
    end
  end
end
