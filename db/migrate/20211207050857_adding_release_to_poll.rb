class AddingReleaseToPoll < ActiveRecord::Migration[6.1]
  def change
    add_column :polls, :is_released, :boolean
  end
end
