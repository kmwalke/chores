class InsertHappinessValues < ActiveRecord::Migration[6.1]
  def change
  execute "INSERT INTO happiness (name) VALUES ('sad');"
  execute "INSERT INTO happiness (name) VALUES ('just fine');"
  execute "INSERT INTO happiness (name) VALUES ('happy');"
  end
end
