require 'spec_helper'

describe Channel do
  let(:channel)     { FactoryGirl.create :channel, publisher: FactoryGirl.create(:spreadsheet) }
  let(:assignee)    { FactoryGirl.create :user }

  before { channel.update_attribute(:assignee_id, assignee.id) }

  describe '#change_publisher' do

    context 'publisher is owned by channel owner' do
      let(:new_publisher) { FactoryGirl.create :spreadsheet, owner: channel.owner }
      it 'is successful and returns true' do
        channel.change_publisher(new_publisher).should == true
        channel.reload.publisher.should == new_publisher
      end
    end

    context 'publisher is owned by channel assignee' do
      let(:new_publisher) { FactoryGirl.create :spreadsheet, owner: channel.assignee }
      it 'is successful and returns true' do
        channel.change_publisher(new_publisher).should == true
        channel.reload.publisher.should == new_publisher
      end
    end

    context 'publisher is not authorized' do
      let(:new_publisher) { FactoryGirl.create :spreadsheet }
      it 'is successful and returns true' do
        channel.change_publisher(new_publisher).should == false
        channel.reload.publisher.should_not == new_publisher
      end
    end
  end
end