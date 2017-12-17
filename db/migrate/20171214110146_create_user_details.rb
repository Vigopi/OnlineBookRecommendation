class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end
