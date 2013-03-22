class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :description, null: false
      t.integer :value, null: false
      t.timestamps
    end
  end
end
