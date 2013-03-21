class CreateSpreadsheets < ActiveRecord::Migration
  def change
    create_table :spreadsheets do |t|
      t.integer :uuid,    null: false
      t.string :filename, null: false
    end
  end
end
