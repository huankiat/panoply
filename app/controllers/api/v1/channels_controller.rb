class Api::V1::ChannelsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_json
  respond_to :json

  def index
    @channels = Channel.all
    respond_with :api, @channels, location: nil
  end

  def show
    @channel = Channel.find(params[:id])
    respond_with :api, @channel, location: nil
  end

  def create
    @channel = Channel.create(params[:channel])
    respond_with :api, @channel, location: nil
  end

  def update
    @channel = Channel.find(params[:id])
    @channel.update_attributes(params[:channel])
    respond_with :api, @channel, location: nil
  end

  private

  def not_found_json
    render :json => "", :status => :not_found and return
  end
end
