class Publication < ActiveRecord::Base
  belongs_to :channel
  belongs_to :spreadsheet

  attr_accessible :channel_id, :spreadsheet_id, :metadata
end