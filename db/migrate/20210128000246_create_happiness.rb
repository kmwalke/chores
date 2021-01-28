class CreateHappiness < ActiveRecord::Migration[6.1]
  def change
    create_table :happiness do |t|
      t.string :name, null: false
    end
	add_index :happiness, :name, unique: true
  end
end
