class Channel < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :value

  attr_accessible :spreadsheet_id, :description, :value, :metadata, :created_at, :updated_at

  has_many :publications
  has_many :publishers, through: :publications, source: :spreadsheet

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :spreadsheet
end