class ChannelsController < ApplicationController

  respond_to :html

  def index
    @channels = Channel.all
    respond_with @channels
  end

end