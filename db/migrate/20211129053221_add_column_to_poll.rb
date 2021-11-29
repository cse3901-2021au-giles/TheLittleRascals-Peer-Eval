class AddColumnToPoll < ActiveRecord::Migration[6.1]
  def change
    add_column :polls, :is_complete, :boolean
  end
end
