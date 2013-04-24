class Api::V1::BroadcastsController < Api::V1::APIController
  before_filter :authenticate_user!

  def index
    @broadcasts = Broadcast.includes(:channels).where(owner_id: current_user.id)
  end

end