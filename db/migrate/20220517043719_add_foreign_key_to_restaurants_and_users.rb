class AddForeignKeyToRestaurantsAndUsers < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :restaurants, :users, column: :user_id

  end
end
