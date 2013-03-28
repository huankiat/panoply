class Api::V1::PublicationsController < Api::V1::APIController
  def create
    channel = Channel.find(params[:publication][:channel_id])
    spreadsheet = Spreadsheet.find(params[:publication][:spreadsheet_id])
    @publication = channel.add_publisher(spreadsheet, params[:publication][:metadata])
    respond_with :api, @publication, location: nil
  end
end
