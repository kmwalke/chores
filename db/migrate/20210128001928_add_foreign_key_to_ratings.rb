class AddForeignKeyToRatings < ActiveRecord::Migration[6.1]
  def change
   add_foreign_key :ratings, :happiness, column: :happiness, primary_key: :name
  end
end
