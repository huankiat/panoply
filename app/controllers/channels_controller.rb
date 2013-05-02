class ChannelsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def index
    @broadcasts = Broadcast.where(owner_id: current_user.id).includes(:channels)
    respond_with @broadcasts
  end

  def new
    @channel = Channel.new
    @broadcasts = current_user.broadcasts
  end

  def create
    broadcast_ids = params[:channel][:broadcast_ids]
    broadcast_ids.delete('')
    channel_params = params[:channel].except(:broadcast_ids)
    @channel = Channel.new(channel_params.merge(owner_id: current_user.id))
    if @channel.save
      broadcast_ids.each do |broadcast_id|
        broadcast = Broadcast.find(broadcast_id)
        broadcast.channels << @channel if broadcast && broadcast.owner == current_user
      end
      respond_with @channel, location: channels_url
    else
      @broadcasts = current_user.broadcasts
      render :new
    end
  end


end