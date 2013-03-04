require 'spec_helper'

describe LandingPagesController do

  describe 'POST #signup' do
    let(:params) {
      {signup: { name: 'Amerson', email: 'amerson@processclick.com' }}
    }

    context 'when params are valid' do
      it 'creates a signup' do
        expect{
          post :signup, params
        }.to change{Signup.count}.by(1)
        session[:flash].should be_present
        response.should redirect_to(root_url)
      end
    end

    context 'when params are invalid' do
      let(:params){
        { signup: { name: 'Amerson', email: 'amerson@processclick' }}
      }
      it 'returns error and redirects' do
        expect{
          post :signup, params
        }.to_not change{Signup.count}
        response.should render_template(:home)
      end
    end
  end

end