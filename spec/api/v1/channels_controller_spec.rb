require 'spec_helper'

describe Api::V1::ChannelsController do

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