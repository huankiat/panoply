require 'spec_helper'

describe BroadcastsController do
  render_views

  let(:user) { FactoryGirl.create :user }
  let(:broadcast) { user.broadcasts.first }

  before { sign_in user }

  describe 'GET #followers' do
    def do_request(params={})
      get :followers, { id: broadcast.id }.merge(params)
    end

    it 'works' do
      do_request
      response.should be_success
    end
  end

  describe 'PUT followers' do
    let(:new_user)  { FactoryGirl.create :user }

    def do_request()
      put :add_followers, { id: broadcast.id }.merge(params)
    end

    context 'when follower_ids contains a blank' do
      let(:params) {{
          broadcast: { follower_ids: ['', new_user.id] }
      }}
      it 'adds the user as a follower' do
        expect {
          do_request
        }.to change{broadcast.followers.count}.by(1)
        response.should redirect_to(channels_path)
      end
    end

  end
end