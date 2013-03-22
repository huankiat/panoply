require 'spec_helper'

describe Spreadsheet do
  let(:spreadsheet) { FactoryGirl.create :spreadsheet }
  let(:channel)     { FactoryGirl.create :channel }

  describe '.register_as_publisher' do
    it 'creates a new publication' do
      expect{
        spreadsheet.register_as_publisher(channel.id, 'location metadata')
      }.to change{Publication.count}.by(1)
      publication = Publication.last
      publication.metadata.should == 'location metadata'
    end
  end
end