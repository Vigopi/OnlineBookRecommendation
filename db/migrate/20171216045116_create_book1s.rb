class CreateBook1s < ActiveRecord::Migration
  def change
    create_table :book1s do |t|
      t.string :name
      t.string :author
      t.string :picture
      t.string :category
      t.string :file

      t.timestamps null: false
    end
  end
end
