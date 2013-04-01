class AddOwnerAndAssigneeToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :owner_id, :integer
    add_column :channels, :assignee_id, :integer
    add_index :channels, :owner_id
    add_index :channels, :assignee_id
  end
end
