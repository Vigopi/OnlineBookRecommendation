class CreateUserCategories < ActiveRecord::Migration
  def change
    create_table :user_categories do |t|
      t.integer :userid
      t.string :category

      t.timestamps null: false
    end
  end
end
