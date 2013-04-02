class ChangeChannelValueToString < ActiveRecord::Migration
  def change
    change_column :channels, :value, :string
  end
end
