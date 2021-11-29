class AddColumn2ToPoll < ActiveRecord::Migration[6.1]
  def change
    add_column :polls, :team_id, :integer
  end
end
