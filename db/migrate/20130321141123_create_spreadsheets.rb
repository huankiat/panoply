class CreateSpreadsheets < ActiveRecord::Migration
  def change
    create_table :spreadsheets do |t|
      t.string :uuid,    null: false
      t.string :filename, null: false
      t.timestamps
    end
  end
end
