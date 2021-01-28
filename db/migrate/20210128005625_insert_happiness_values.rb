class InsertHappinessValues < ActiveRecord::Migration[6.1]
  def up
  execute "INSERT INTO happiness (name) VALUES ('sad');"
  execute "INSERT INTO happiness (name) VALUES ('just fine');"
  execute "INSERT INTO happiness (name) VALUES ('happy');"
  end
  def down
  end
end
