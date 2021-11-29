class ChangeTeamColumnName < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :description, :string
  end
end
