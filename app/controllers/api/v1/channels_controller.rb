class Api::V1::ChannelsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_json
  respond_to :json

  def index
    @channels = Channel.all
    respond_with :api, @channels
  end

  def show
    @channel = Channel.find(params[:id])
    respond_with :api, @channel
  end

  def create
    @channel = Channel.create(params[:channel])
    respond_with :api, @channel
  end

  def create_and_publish
    spreadsheet = Spreadsheet.find(params[:spreadsheet_id])
    @channel = Channel.create(params[:channel])
    @channel.add_publisher(spreadsheet)
    respond_with :api, @channel
  end

  def update
    @channel = Channel.find(params[:id])
    if @channel.spreadsheet_id == params[:channel][:spreadsheet_id].to_i || params[:override].present?
      @channel.update_attributes(params[:channel])
      respond_with :api, @channel
    else
      respond_with :api, @channel, status: :forbidden
    end
  end

  private

  def not_found_json
    render :json => "", :status => :not_found and return
  end
end
