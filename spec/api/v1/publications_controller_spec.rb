require 'spec_helper'

describe Api::V1::PublicationsController do
  let(:channel)     { FactoryGirl.create :channel }
  let(:spreadsheet) { FactoryGirl.create :spreadsheet }

  describe 'POST #create' do
    let(:params) {
      {
        publication: {
            channel_id: channel.id,
            spreadsheet_id: spreadsheet.id,
            metadata: 'sales-F3'
        }
      }
    }
    it 'creates a publication' do
      expect {
        post 'api/publications.json', params
      }.to change{Publication.count}.by(1)
      Publication.last.metadata.should == 'sales-F3'
    end
  end

end