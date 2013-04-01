class Channel < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :value

  attr_accessible :description, :value, :spreadsheet_id

  belongs_to :publisher, class_name: 'Spreadsheet', foreign_key: 'spreadsheet_id'

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :spreadsheet
end