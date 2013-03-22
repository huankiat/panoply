class Spreadsheet < ActiveRecord::Base
  validates_presence_of :uuid
  validates_uniqueness_of :uuid

  validates_presence_of :filename

  has_many :published_channels, class_name: :channel
  has_many :subscribed_channels, through: :subscriptions
end