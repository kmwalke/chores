class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :user_id
      t.integer :frequency
      t.integer :size
      t.integer :xp

      t.timestamps
    end
  end
end
