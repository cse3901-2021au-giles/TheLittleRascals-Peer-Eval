class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.integer :group_id
      t.string :name
      t.string :description
      t.boolean :has_group

      t.timestamps
    end
  end
end
