class DeleteColumn2ToPoll < ActiveRecord::Migration[6.1]
  def change
    remove_column :polls, :team_id
    remove_column :polls, :is_complete
  end
end
