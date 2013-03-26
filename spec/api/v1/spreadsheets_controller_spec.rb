require 'spec_helper'

describe Api::V1::SpreadsheetsController do

  describe 'POST #create' do
    let(:params) {
      { spreadsheet:  { filename: 'sales.xlsx' } }
    }
    it 'creates a spreadsheet' do
      expect {
        post 'api/spreadsheets.json', params
      }.to change{Spreadsheet.count}.by(1)
      Spreadsheet.last.filename.should == 'sales.xlsx'

      JSON.parse(response.body)['id'].should == Spreadsheet.last.id
    end
    it 'generates a fixture', generate_fixture: true do
      write_JSON_to_file('v1.spreadsheets.create.request', params)
      post 'api/spreadsheets.json', params
      write_JSON_to_file('v1.spreadsheets.create.response', JSON.parse(response.body))
    end
  end

end