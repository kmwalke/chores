class CreateDaysSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :days_schedules do |t|
      t.string :day, null: false
      t.integer :schedule_id, null: false
    end

    add_index :days_schedules, [:day, :schedule_id], unique: true
    # add_foreign_key :days_schedules, :day
    # add_foreign_key :days_schedules, :schedules
  end
end
