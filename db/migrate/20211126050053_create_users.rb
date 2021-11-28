class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :password
      t.boolean :admin

      t.timestamps
    end
  end
end
