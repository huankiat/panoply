class ChannelsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def index
    @broadcasts = Broadcast.where(owner_id: current_user.id).includes(:channels)
    respond_with @broadcasts
  end

end