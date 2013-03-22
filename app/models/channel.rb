class Channel < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :value

  attr_accessible :description, :value

  has_many :publications
  has_many :publishers, through: :publications, source: :spreadsheet

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :spreadsheet

  def add_publisher(spreadsheet, metadata)
    if self.publications.empty?
      Publication.create(channel_id: self.id, spreadsheet_id: spreadsheet.id, metadata: metadata, primary: true)
    else
      Publication.create(channel_id: self.id, spreadsheet_id: spreadsheet.id, metadata: metadata, primary: false)
    end
  end

  def primary_publisher
    Publication.where(channel_id: self.id, primary: true).first.spreadsheet
  end

  def set_primary_publisher(spreadsheet)
    publications.each do |pub|
      if pub.spreadsheet == spreadsheet
        pub.update_attribute(:primary, true)
      else
        pub.update_attribute(:primary, false)
      end
    end
  end
end