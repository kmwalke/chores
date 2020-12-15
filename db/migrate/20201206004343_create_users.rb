class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.integer :level, default: 1, null: false
      t.integer :xp, default: 0, null: false
      t.decimal :xp_multiplier, default: 1, null: false
      t.integer :role_id

      t.timestamps
    end
  end
end
