class Channel < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :value

  attr_accessible :spreadsheet_id, :description, :value, :metadata

  belongs_to :publisher, foreign_key: :spreadsheet_id, class_name: 'Spreadsheet'
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :spreadsheet
end