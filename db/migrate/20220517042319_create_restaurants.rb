class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :restaurant_name
      t.string :address
      t.time :opening_time
      t.time :closing_time
      t.boolean :veg_restaurant
      t.bigint :user_id

      t.timestamps
    end
  end
end
