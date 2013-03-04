class Signup < ActiveRecord::Base

  validates_presence_of :email
  validates :email, :format => { :with => /.+@.+\..+/i }

  attr_accessible :name, :email
end