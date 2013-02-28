require 'spec_helper'

describe Api::V1::ChannelsController do

  describe 'GET #index' do
    it 'returns a list of ids and descriptions of each channel' do
      get 'api/channels.json'

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

end