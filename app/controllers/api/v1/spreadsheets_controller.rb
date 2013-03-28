class Api::V1::SpreadsheetsController < Api::V1::APIController
  def create
    @spreadsheet = Spreadsheet.create(params[:spreadsheet])
    respond_with :api, @spreadsheet, location: nil
  end
end
