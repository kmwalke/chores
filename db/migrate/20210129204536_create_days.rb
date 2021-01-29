class CreateDays < ActiveRecord::Migration[6.1]
  def up
    create_table :days, id: false do |t|
      t.string :name, null: false
    end

    add_index :days, :name, unique: true

    execute "insert into days values ('monday')"
    execute "insert into days values ('tuesday')"
    execute "insert into days values ('wednesday')"
    execute "insert into days values ('thursday')"
    execute "insert into days values ('friday')"
    execute "insert into days values ('saturday')"
    execute "insert into days values ('sunday')"
  end

  def down
    drop_table :days
  end
end
