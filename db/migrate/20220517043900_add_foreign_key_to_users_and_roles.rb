class AddForeignKeyToUsersAndRoles < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :users, :roles, column: :role_id

  end
end
