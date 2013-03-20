class CreateTeamsUsers < ActiveRecord::Migration
  def change
    create_table :teams_users, id: false do |t|
      t.references :team, :user
    end
    add_index :teams_users, [:team_id, :user_id]
    add_index :teams_users, [:user_id, :team_id]
  end
end
