class CreatePolls < ActiveRecord::Migration[6.1]
  def change
    create_table :polls do |t|
      t.integer :project_id
      t.string :description
      t.datetime :end_date

      t.timestamps
    end
  end
end
