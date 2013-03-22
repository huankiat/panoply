class Spreadsheet < ActiveRecord::Base
  validates_presence_of :uuid
  validates_uniqueness_of :uuid

  validates_presence_of :filename

  has_many :published_channels, class_name: :channel
  has_many :subscribed_channels, through: :subscriptions

  def register_as_publisher(channel_id, metadata)
    Publication.create(channel_id: channel_id, spreadsheet_id: self.id, metadata: metadata)
  end
end