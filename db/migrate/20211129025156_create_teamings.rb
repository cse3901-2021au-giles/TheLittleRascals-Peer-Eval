class CreateTeamings < ActiveRecord::Migration[6.1]
  def change
    create_table :teamings do |t|
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end
end
