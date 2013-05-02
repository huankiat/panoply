class ChannelValueCanBeNull < ActiveRecord::Migration
  def change
    change_column :channels, :value, :string, :null => true
  end
end
