class AddOwerColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :owner, :integer
  end
end
