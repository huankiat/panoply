require 'spec_helper'

describe Channel do
  let(:channel)     { FactoryGirl.create :channel, publisher: FactoryGirl.create(:spreadsheet) }
  let(:assignee)    { FactoryGirl.create :user }

  before { channel.update_attribute(:assignee_id, assignee.id) }

  describe '.owned_by(user)' do
    let!(:amerson)      { FactoryGirl.create :user }
    let!(:huankiat)     { FactoryGirl.create :user }
    let!(:channel_1)    { FactoryGirl.create :channel, owner: amerson }
    let!(:channel_2)    { FactoryGirl.create :channel, owner: amerson }
    let!(:channel_3)    { FactoryGirl.create :channel, owner: huankiat }

    it 'is correct' do
      Channel.owned_by(amerson).should =~ [channel_1, channel_2]
      Channel.owned_by(huankiat).should == [channel_3]
    end
  end

  describe '.visible_to(user)' do
    let!(:amerson)      { FactoryGirl.create :user }
    let!(:huankiat)     { FactoryGirl.create :user }
    let!(:spreadsheet)  { FactoryGirl.create :spreadsheet, owner: amerson }
    let!(:channel_1)    { FactoryGirl.create :channel, owner: amerson }
    let!(:channel_2)    { FactoryGirl.create :channel, owner: huankiat }
    let!(:channel_3)    { FactoryGirl.create :channel, owner: huankiat }

    before do
      channel_2.add_subscriber(spreadsheet)
    end

    it 'is a union of channels owned by user and subscribed to by user' do
      Channel.visible_to(amerson).should =~ [channel_1, channel_2]
    end
  end

  describe '#change_publisher' do
    let(:new_publisher) { FactoryGirl.create :spreadsheet, owner: channel.owner }

    context 'when user is channel owner' do
      it 'is successful and returns true' do
        channel.change_publisher(channel.owner, new_publisher).should == true
        channel.reload.publisher.should == new_publisher
      end
    end

    context 'publisher is owned by channel assignee' do
      it 'is successful and returns true' do
        channel.change_publisher(channel.assignee, new_publisher).should == true
        channel.reload.publisher.should == new_publisher
      end
    end

    context 'publisher is not authorized' do
      it 'is successful and returns true' do
        channel.change_publisher(FactoryGirl.create(:user), new_publisher).should == false
        channel.reload.publisher.should_not == new_publisher
      end
    end
  end
end