class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :occurrences, comment: 'null means occur forever'
      t.date :due_date, comment: 'null means no particular due date'
      t.integer :model_id, null: false
      t.string :model_type, null: false
    end
  end
end
