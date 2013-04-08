class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.string :description
      t.integer :owner_id
      t.timestamps
    end

    create_table :broadcasts_users do |t|
      t.integer :broadcast_id
      t.integer :user_id
    end
    add_index :broadcasts_users, [:broadcast_id, :user_id]
    add_index :broadcasts_users, [:user_id, :broadcast_id]

    create_table :broadcasts_channels do |t|
      t.integer :broadcast_id
      t.integer :channel_id
    end
    add_index :broadcasts_channels, [:broadcast_id, :channel_id]
    add_index :broadcasts_channels, [:channel_id, :broadcast_id]
  end
end
