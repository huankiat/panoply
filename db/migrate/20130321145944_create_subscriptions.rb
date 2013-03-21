class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :channel
      t.references :spreadsheet
      t.timestamps
    end

    add_index :subscriptions, [:channel_id, :spreadsheet_id]
    add_index :subscriptions, [:spreadsheet_id, :channel_id]
  end
end
