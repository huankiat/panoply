class Channel < ActiveRecord::Base
  validates_presence_of :description

  attr_accessible :description, :value, :owner_id, :spreadsheet_id

  belongs_to :publisher, class_name: 'Spreadsheet', foreign_key: 'spreadsheet_id'

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :spreadsheet

  belongs_to :owner, class_name: 'User'
  belongs_to :assignee, class_name: 'User'

  has_and_belongs_to_many :broadcasts

  scope :owned_by,   ->(user) { where(owner_id: user.id) }
  scope :visible_to, ->(user) { joins("LEFT OUTER JOIN subscriptions ON channels.id = subscriptions.channel_id")
                                  .joins("LEFT OUTER JOIN spreadsheets ON spreadsheets.id = subscriptions.spreadsheet_id")
                                  .where('channels.owner_id = ? OR spreadsheets.owner_id = ?', user.id, user.id) }

  def change_publisher(user, spreadsheet)
    if user == self.owner || user == self.assignee
      self.publisher = spreadsheet
      self.save
    else
      return false
    end
  end

  def add_subscriber(spreadsheet)
    unless self.subscribers.include? spreadsheet
      self.subscribers << spreadsheet
    end
  end
end