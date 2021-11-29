class ChangeColumnNameProject < ActiveRecord::Migration[6.1]
  def change
    rename_column :projects, :has_group, :has_team
  end
end
