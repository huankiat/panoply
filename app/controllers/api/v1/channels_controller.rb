class Api::V1::ChannelsController < ApplicationController
  respond_to :json

  def index
    @channels = Channel.all
    respond_with :api, @channels, location: nil
  end

  def create
    @channel = Channel.create(params[:channel])
    respond_with :api, @channel, location: nil
  end

end
