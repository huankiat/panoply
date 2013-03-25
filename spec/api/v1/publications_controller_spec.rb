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

    it 'generates a fixture', generate_fixture: true do
      write_JSON_to_file('v1.publications.create.request.json', params)
      post 'api/publications.json', params
      write_JSON_to_file('v1.publications.create.response.json', JSON.parse(response.body))
    end
  end

end