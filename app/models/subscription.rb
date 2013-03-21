class Subscription < ActiveRecord::Base
  belongs_to :channel
  belongs_to :spreadsheet
end