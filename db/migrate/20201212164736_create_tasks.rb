class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.integer :frequency, null: false
      t.integer :size, null: false
      t.integer :xp, null: false

      t.timestamps
    end
  end
end
