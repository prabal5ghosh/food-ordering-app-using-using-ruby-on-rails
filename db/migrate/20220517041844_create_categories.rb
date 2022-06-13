class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :catagory_name

      t.timestamps
    end
  end
end
