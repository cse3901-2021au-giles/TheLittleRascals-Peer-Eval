class AddColumn2ToRes < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :team_id, :integer
    add_column :results, :is_complete, :boolean
  end
end
