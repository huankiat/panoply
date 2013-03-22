class Subscription < ActiveRecord::Base
  belongs_to :channel
  belongs_to :spreadsheet
  attr_accessible :spreadsheet_id, :channel_id, :metadata
end