class AddDefault < ActiveRecord::Migration[6.1]
  def change
    change_column :polls, :is_released, :boolean, :default=> false
  end
end
