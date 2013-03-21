class Channel < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :value

  attr_accessible :description, :value

  belongs_to :spreadsheet
end