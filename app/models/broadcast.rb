class Broadcast < ActiveRecord::Base

  has_and_belongs_to_many :channels
  has_many :followers, class_name: 'User', foreign_key: 'user_id'

  belongs_to :owner, class_name: 'User'

  attr_accessible :description, :owner_id

end