class Api::V1::PublicationsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_json
  respond_to :json

  def create
    channel = Channel.find(params[:publication][:channel_id])
    spreadsheet = Spreadsheet.find(params[:publication][:spreadsheet_id])
    @publication = channel.add_publisher(spreadsheet, params[:publication][:metadata])
    respond_with :api, @publication, location: nil
  end

  private

  def not_found_json
    render :json => "", :status => :not_found and return
  end
end
