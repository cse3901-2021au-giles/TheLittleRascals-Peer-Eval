class ChangeColumnDate < ActiveRecord::Migration[6.1]
  def change
    change_column :polls, :end_date, :date
  end
end
