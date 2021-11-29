class AddGroupIdToPoll < ActiveRecord::Migration[6.1]
  def change
    add_column :polls, :group_id, :integer
  end
end
