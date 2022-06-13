class AddForeignKeyToFooditemsAndRestaurantsAndCategories < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :fooditems, :restaurants, column: :restaurant_id
    add_foreign_key :fooditems, :categories, column: :category_id
  end
end

