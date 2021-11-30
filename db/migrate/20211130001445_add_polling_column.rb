class AddPollingColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :pollings, :is_complete, :boolean
  end
end
