require 'spec_helper'

describe Api::V1::ChannelsController do

  describe 'GET #index' do
    let!(:channel1) { FactoryGirl.create :channel }
    let!(:channel2) { FactoryGirl.create :channel }
    it 'returns a list of ids and descriptions of each channel' do
      get 'api/channels.json'
      json = JSON.parse(response.body)['channels']
      json.size.should == 2
      json[0]['id'].should == channel1.id
      json[1]['id'].should == channel2.id
    end
  end

  describe 'GET #show' do
    let!(:channel) { FactoryGirl.create :channel }
    context 'when channel exists' do
      it 'returns all parameters of a channel' do
        get "api/channels/#{channel.id}.json"
        json = JSON.parse(response.body)['channel']
        json['id'].should == channel.id
        json['description'].should == channel.description
        json['value'].should == channel.value
      end
    end
    context 'when channel does not exist' do
      it 'returns 404' do
        get "api/channels/#{Channel.last.id+1}.json"
        response.should be_not_found
      end
    end
  end

  describe 'POST #create' do
    context 'when params are valid' do
      let(:params) {
        { channel:
          { description: 'asdf', value: 123 }
        }
      }
      it 'creates a channel' do
        expect {
          post 'api/channels.json', params
        }.to change{Channel.count}.by(1)
        JSON.parse(response.body)['id'].should == Channel.last.id
        JSON.parse(response.body)['description'].should == 'asdf'
      end
    end

    context 'when params are valid' do
      let(:params) {
        { channel:
          { description: 'asdf' }
        }
      }
      it 'creates a channel' do
        post 'api/channels.json', params
        response.should be_unprocessable
      end
    end
  end

  describe 'PUT #update' do
    let!(:channel) { FactoryGirl.create :channel }
    let!(:params) {
      { channel: channel.attributes.merge!(value: channel.value + 1) }
      }

    context 'when channel exists' do
      it 'updates' do
        put "api/channels/#{channel.id}.json", params
        json = JSON.parse(response.body)['channel']
        json['id'].should == channel.id
        json['value'].should == channel.value + 1
      end
    end
    context 'when channel does not exist' do
      it 'returns 404' do
        put "api/channels/#{Channel.last.id + 1}.json", params
        response.should be_not_found
      end
    end
  end

end