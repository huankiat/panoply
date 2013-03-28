class Channel < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :value

  attr_accessible :description, :value

  has_many :publications
  has_many :publishers, through: :publications, source: :spreadsheet

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :spreadsheet

  def add_publisher(spreadsheet, metadata=nil)
    if self.publications.empty?
      Publication.create(channel_id: self.id, spreadsheet_id: spreadsheet.id, metadata: metadata)
      self.set_primary_publisher(spreadsheet)
    else
      Publication.create(channel_id: self.id, spreadsheet_id: spreadsheet.id, metadata: metadata)
    end
  end

  def primary_publisher
    Spreadsheet.find(spreadsheet_id)
  end

  def set_primary_publisher(spreadsheet)
    self.update_attribute(:spreadsheet_id, spreadsheet.id)
  end
end