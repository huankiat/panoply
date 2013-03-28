require 'spec_helper'

describe Api::V1::TokensController do
  let(:user) { FactoryGirl.create :user }

  describe 'POST #create' do
    def do_request(params={})
      post "/api/tokens.json", { email: user.email, password: user.password }.merge(params)
    end

    context 'when Devise authentication is successful' do
      before { do_request }

      it 'responds with 201' do
        response.code.should == '201'
      end

      it 'responds with id, email and auth token' do
        user.reload.authentication_token.should_not == nil
        JSON.parse(response.body)['id'].should          == user.id
        JSON.parse(response.body)['email'].should       == user.email
        JSON.parse(response.body)['authentication_token'].should  == user.authentication_token
      end
    end

    context 'when Devise authentication is unsuccessful' do
      before { do_request({email: user.email, password: 'wrong password'}) }
      it 'responds with unauthorized' do
        response.code.should == '401'
      end
    end
  end
end
