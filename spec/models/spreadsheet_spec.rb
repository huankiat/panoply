require 'spec_helper'

describe Spreadsheet do
  let(:channel) { FactoryGirl.create :channel }
  let(:spreadsheet_1) { FactoryGirl.create :spreadsheet }
  let(:spreadsheet_2) { FactoryGirl.create :spreadsheet }

  describe '.subscribe_to_channel' do
    it 'works' do
      spreadsheet_1.subscribe_to_channel(channel)
      spreadsheet_2.subscribe_to_channel(channel)
      channel.reload.subscribers.should =~ [spreadsheet_1, spreadsheet_2]
    end
  end

end