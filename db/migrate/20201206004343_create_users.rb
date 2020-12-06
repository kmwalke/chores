class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.integer :level
      t.integer :xp
      t.decimal :xp_multiplier
      t.integer :role_id

      t.timestamps
    end
  end
end
