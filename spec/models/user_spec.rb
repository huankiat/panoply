require 'spec_helper'

describe User do

  describe 'after_create callback' do
    it 'creates a users first broadcast' do
      expect {
        FactoryGirl.create :user
      }.to change{Broadcast.count}.by(1)
    end
  end
end
