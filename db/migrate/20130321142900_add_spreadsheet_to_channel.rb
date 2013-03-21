class AddSpreadsheetToChannel < ActiveRecord::Migration
  def change
    change_table :channels do |t|
      t.references :spreadsheet, null: false
      t.string :metadata,        null: false
    end
  end
end
