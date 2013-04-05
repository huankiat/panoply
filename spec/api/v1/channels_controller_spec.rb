require 'spec_helper'

describe Api::V1::ChannelsController do
  let(:user) { FactoryGirl.create :user }
  before { user.ensure_authentication_token! }

  describe 'GET #index' do
    let!(:channel1) { FactoryGirl.create :channel, owner: user }
    let!(:channel2) { FactoryGirl.create :channel }

    def do_request(params={})
      get 'api/channels.json', params, { "HTTP_AUTHORIZATION" => "Token token=#{user.reload.authentication_token}" }
    end

    before do
      channel2.assignee = user
      channel2.save
    end

    it 'returns a list of ids and descriptions of all channels that a user can publish to' do
      do_request
      json = JSON.parse(response.body)['channels']
      json.size.should == 2
      json[0]['id'].should == channel1.id
      json[1]['id'].should == channel2.id
    end

    it 'filters to channels that user owns with filter=owner' do
      do_request(filter: 'owner')
      json = JSON.parse(response.body)['channels']
      json.size.should == 1
      json[0]['id'].should == channel1.id
    end

    it 'generates a fixture', generate_fixture: true do
      get 'api/channels.json'
      write_JSON_to_file('v1.channels.index.response', JSON.parse(response.body))
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

    it 'generates a fixture', generate_fixture: true do
      get "api/channels/#{channel.id}.json"
      write_JSON_to_file('v1.channels.show.response', JSON.parse(response.body))
    end
  end

  describe 'POST #create' do
    def do_request(params={})
      post 'api/channels.json', params, { "HTTP_AUTHORIZATION" => "Token token=#{user.reload.authentication_token}" }
    end

    context 'when params are valid' do
      let(:params) {
        { channel: { description: 'asdf', value: 123 } }
      }

      it 'creates a channel' do
        expect {
          do_request(params)
        }.to change{Channel.count}.by(1)
        JSON.parse(response.body)['id'].should == Channel.last.id
        JSON.parse(response.body)['description'].should == 'asdf'
      end

      it 'channel owner is current user' do
        do_request(params)
        Channel.last.owner.should == user
      end

      it 'generates a fixture', generate_fixture: true do
        write_JSON_to_file('v1.channels.create.request', params)
        post 'api/channels.json', params
        write_JSON_to_file('v1.channels.create.response', JSON.parse(response.body))
      end
    end

    context 'when params contain a spreadsheet id' do
      let(:spreadsheet) { FactoryGirl.create :spreadsheet }
      let(:params) {
        { channel:  { description: 'asdf', value: 123, spreadsheet_id: spreadsheet.id } }
      }
      it 'sets the publisher' do
        do_request(params)
        channel = Channel.last
        channel.publisher.should == spreadsheet
      end
    end

    context 'when params are invalid' do
      let(:params) {
        { channel:
          { description: 'asdf' }
        }
      }
      it 'creates a channel' do
        do_request(params)
        response.should be_unprocessable
      end
    end
  end

  describe 'PUT #update' do
    let!(:publisher)  { FactoryGirl.create :spreadsheet }
    let!(:channel)    { FactoryGirl.create :channel, publisher: publisher }
    let(:assignee)    { FactoryGirl.create :user}
    let(:params) {
      { channel: { description: channel.description, value: -1, spreadsheet_id: publisher.id} }
    }

    before { channel.update_attribute(:assignee_id, assignee.id) }

    context 'when channel exists' do
      it 'updates' do
        put "api/channels/#{channel.id}.json", params
        json = JSON.parse(response.body)['channel']
        json['id'].should == channel.id
        json['value'].should == '-1'
      end
    end

    context 'when channel does not exist' do
      it 'returns 404' do
        put "api/channels/#{Channel.last.id + 1}.json", params
        response.should be_not_found
      end
    end

    context "when the publishing spreadsheet is not the channel's publisher" do
      let(:new_publisher) { FactoryGirl.create :spreadsheet }
      let(:params) {
        { channel: { description: channel.description, value: -1, spreadsheet_id: new_publisher.id} }
      }
      it 'returns a 409' do
        put "api/channels/#{channel.id}.json", params
        response.code.should == '409'
      end
    end

    context "when there is force: true" do
      let(:params) {
        { channel: { description: channel.description, value: -1, spreadsheet_id: new_publisher.id },
          force: true }
      }

      context 'new publishing spreadsheet belongs to channel owner' do
        let(:new_publisher) { FactoryGirl.create :spreadsheet, owner: channel.owner }
        it 'succeeds' do
          put "api/channels/#{channel.id}.json", params
          response.should be_success
          channel.reload.publisher.should == new_publisher
        end
      end

      context 'new publishing spreadsheet belongs to channel assignee' do
        let(:new_publisher) { FactoryGirl.create :spreadsheet, owner: channel.assignee }
        it 'succeeds' do
          put "api/channels/#{channel.id}.json", params
          response.should be_success
          channel.reload.publisher.should == new_publisher
        end
      end

      context 'new publishing spreadsheet belongs to neither owner nor assignee' do
        let(:new_publisher) { FactoryGirl.create :spreadsheet }
        it 'fails' do
          put "api/channels/#{channel.id}.json", params
          response.code.should == '403'
          channel.reload.publisher.should_not == new_publisher
        end
      end

      it 'generates a fixture', generate_fixture: true do
        write_JSON_to_file('v1.channels.update.request', params)
        put "api/channels/#{channel.id}.json", params
        write_JSON_to_file('v1.channels.update.response', JSON.parse(response.body))
      end
    end
  end

end