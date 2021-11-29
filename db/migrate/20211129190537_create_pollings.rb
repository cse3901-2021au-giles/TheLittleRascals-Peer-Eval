class CreatePollings < ActiveRecord::Migration[6.1]
  def change
    create_table :pollings do |t|
      t.integer :poll_id
      t.integer :user_id

      t.timestamps
    end
  end
end
