class CreateFooditems < ActiveRecord::Migration[7.0]
  def change
    create_table :fooditems do |t|
      t.string :food_name
      t.float :price
      t.boolean :veg_food
      t.bigint :category_id
      t.bigint :restaurant_id

      t.timestamps
    end
  end
end
