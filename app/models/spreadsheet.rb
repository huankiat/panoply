class Spreadsheet < ActiveRecord::Base
  validates_presence_of :filename

  has_many :published_channels, class_name: :channel
  has_many :subscribed_channels, through: :subscriptions

  belongs_to :owner, class_name: 'User'

  attr_accessible :filename

  def subscribe_to_channel(channel)
    Subscription.create(channel_id: channel.id, spreadsheet_id: self.id, metadata: 'sales-D3')
  end
end