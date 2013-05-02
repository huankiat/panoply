class BroadcastsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def new
    @broadcast = Broadcast.new
  end

  def create
    @broadcast = Broadcast.create(params[:broadcast].merge(owner_id: current_user.id))
    respond_with @broadcast, location: channels_url
  end

end