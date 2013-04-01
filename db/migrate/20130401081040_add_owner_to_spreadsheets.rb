class AddOwnerToSpreadsheets < ActiveRecord::Migration
  def change
    add_column :spreadsheets, :owner_id, :integer
    add_index :spreadsheets, :owner_id
  end
end
