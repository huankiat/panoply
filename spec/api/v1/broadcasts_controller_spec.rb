require 'spec_helper'

describe Api::V1::BroadcastsController do
  let(:user) { FactoryGirl.create :user }   # a broadcast is automatically created
  before { user.ensure_authentication_token! }

  describe 'GET #index' do
    let(:broadcast) { FactoryGirl.create :broadcast }
    let(:channel) { FactoryGirl.create :channel }

    def do_request(params={})
      get 'api/broadcasts.json', params, { "HTTP_AUTHORIZATION" => "Token token=#{user.reload.authentication_token}" }
    end

    before do
      broadcast = user.broadcasts.first
      broadcast.channels << channel
      broadcast.save
    end

    it 'returns a list of owned broadcasts and channel information' do
      do_request
      json = JSON.parse(response.body)['broadcasts']
      json.size.should == 1
      json[0]['channels'].size.should == 1
    end

    it 'generates a fixture', generate_fixture: true do
      do_request
      write_JSON_to_file('v1.channels.index.response', JSON.parse(response.body))
    end
  end


end