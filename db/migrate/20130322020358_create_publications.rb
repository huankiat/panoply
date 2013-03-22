class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.references :channel
      t.references :spreadsheet
      t.boolean :primary, null: false, default: false
      t.string :metadata
      t.timestamps
    end

    add_index :publications, [:channel_id, :spreadsheet_id]
    add_index :publications, [:spreadsheet_id, :channel_id]
  end
end
