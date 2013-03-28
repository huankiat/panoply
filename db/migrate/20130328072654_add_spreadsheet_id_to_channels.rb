class AddSpreadsheetIdToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :spreadsheet_id, :integer
    remove_column :publications, :primary
  end
end
