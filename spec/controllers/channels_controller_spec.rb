require 'spec_helper'

describe ChannelsController do
  render_views

  let(:user) { FactoryGirl.create :user }

  before { sign_in(user) }

  describe '#create' do
    let(:broadcast)         { user.broadcasts.first }
    let(:unowned_broadcast) { FactoryGirl.create :broadcast }

    def do_request()
      post :create, params
    end

    context 'when multiple broadcasts are selected' do
      let(:params) {{
        channel: { description: 'new channel!', broadcast_ids: [broadcast.id, unowned_broadcast.id] }
      }}
      it 'only adds the channel to the broadcasts owned by the user' do
        expect {
          do_request
        }.to change{Channel.count}.by(1)
        channel = Channel.last
        channel.broadcasts.should == [broadcast]
      end
    end

    context 'when broadcast_ids contains a blank' do
      let(:params) {{
          channel: { description: 'new channel!', broadcast_ids: ['', unowned_broadcast.id] }
      }}
      it 'still creates the channel' do
        expect {
          do_request
        }.to change{Channel.count}.by(1)
      end
    end

    context 'when params are invalid' do
      let(:params) {{
        channel: { description: '', broadcast_ids: [] }
      }}
      it 'does not create a channel' do
        expect {
          do_request
        }.to_not change{Channel.count}.by(1)
      end
    end
  end
end