class Spreadsheet < ActiveRecord::Base
  validates_presence_of :uuid
  validates_uniqueness_of :uuid

  validates_presence_of :filename

  has_many :channels
end