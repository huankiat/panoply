class Channel < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :value

  attr_accessible :description, :value, :owner_id, :spreadsheet_id

  belongs_to :publisher, class_name: 'Spreadsheet', foreign_key: 'spreadsheet_id'

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :spreadsheet

  belongs_to :owner, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
end