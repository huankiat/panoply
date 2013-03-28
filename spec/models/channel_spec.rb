require 'spec_helper'

describe Channel do
  let(:channel) { FactoryGirl.create :channel }
  let(:publisher_1) { FactoryGirl.create :spreadsheet }
  let(:publisher_2) { FactoryGirl.create :spreadsheet }

  describe '.add_publisher' do
    context 'when it is the first publisher' do
      it 'creates a new publication' do
        expect{
          channel.add_publisher(publisher_1, 'location metadata')
        }.to change{Publication.count}.by(1)
        publication = Publication.last
        publication.metadata.should == 'location metadata'
        channel.primary_publisher.should == publisher_1
      end
    end
    context 'when it is an additional publisher' do
      before do
        channel.add_publisher(publisher_1, 'location metadata')
        channel.reload
      end

      it 'creates a non-primary publication' do
        expect{
          channel.add_publisher(publisher_2, 'location metadata')
        }.to change{Publication.count}.by(1)
        publication = Publication.last
        publication.metadata.should == 'location metadata'
        channel.primary_publisher.should == publisher_1
      end
    end
  end

  describe '.set_primary_publisher' do
    it 'sets the primary_publisher' do
      channel.add_publisher(publisher_1, 'location metadata')
      channel.reload.add_publisher(publisher_2, 'location metadata')
      channel.reload.primary_publisher.should == publisher_1
      channel.set_primary_publisher(publisher_2)
      channel.reload.primary_publisher.should == publisher_2
    end
  end
end