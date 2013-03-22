class Api::V1::SpreadsheetsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_json
  respond_to :json

  def create
    @spreadsheet = Spreadsheet.create(params[:spreadsheet])
    respond_with :api, @spreadsheet, location: nil
  end

  private

  def not_found_json
    render :json => "", :status => :not_found and return
  end
end
