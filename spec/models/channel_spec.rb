require 'spec_helper'

describe Channel do

  describe 'associations' do
    let!(:publisher)     { FactoryGirl.create :spreadsheet }
    let!(:channel)       { FactoryGirl.create :channel, publisher: publisher }
    let!(:subscriber)    { FactoryGirl.create :spreadsheet }
    let!(:subscription)  { FactoryGirl.create :subscription, channel: channel, spreadsheet: subscriber }

    it 'has a publisher' do
      channel.publisher.should == publisher
    end

    it 'has subscriptions' do
      channel.subscribers.should == [subscriber]
    end
  end

end