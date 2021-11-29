class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :poll_id
      t.integer :rater_id
      t.integer :ratee_id
      t.integer :score
      t.string :comment

      t.timestamps
    end
  end
end
