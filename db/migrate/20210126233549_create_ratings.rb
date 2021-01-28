class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
	  t.integer :user_id, null: false
	  t.string :happiness, null: false
	  t.text :description
	  t.timestamps
	end
	
	
  end
end
