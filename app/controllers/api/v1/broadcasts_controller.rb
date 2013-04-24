class Api::V1::BroadcastsController < Api::V1::APIController
  before_filter :authenticate_user!

  def index
    if params[:filter] && params[:filter] == 'owned'
      @broadcasts = Broadcast.includes(:channels).where(owner_id: current_user.id)
    else
      @broadcasts = Broadcast.includes(:channels).joins('LEFT OUTER JOIN broadcasts_users ON broadcasts.id = broadcasts_users.broadcast_id').
          where("broadcasts.owner_id = ? OR broadcasts_users.user_id = ?", current_user.id, current_user.id)
    end
  end

end