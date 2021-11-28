class AddingTempUserCheck < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :temp_user, :boolean
  end
end
