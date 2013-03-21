class AddSpreadsheetToChannel < ActiveRecord::Migration
  def up
    change_table :channels do |t|
      t.references :spreadsheet, null: false
      t.string :metadata,        null: false
    end
  end

  def down
    remove_column :channels, :spreadsheet_id
    remove_column :channels, :metadata
  end
end
