class Broadcast < ActiveRecord::Base

  has_and_belongs_to_many :channels
  has_and_belongs_to_many :followers, join_table: 'broadcasts_users', class_name: 'User'

  belongs_to :owner, class_name: 'User'

  attr_accessible :description, :owner_id

  def add_follower(user)
    self.followers << user
    self.save
  end
end