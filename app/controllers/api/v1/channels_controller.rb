class Api::V1::ChannelsController < Api::V1::APIController
  def index
    @channels = Channel.all
    respond_with :api, @channels
  end

  def show
    @channel = Channel.find(params[:id])
    respond_with :api, @channel
  end

  def create
    authenticate_user!
    @channel = Channel.create(params[:channel].merge(owner_id: current_user.id))
    respond_with :api, @channel
  end

  def update
    @channel = Channel.find(params[:id])
    @publisher = Spreadsheet.find(params[:channel][:spreadsheet_id])

    if @channel.publisher == @publisher && @channel.update_attributes(params[:channel])
      respond_with :api, @channel
    elsif @channel.change_publisher(@publisher) && params[:force].present?
      respond_with :api, @channel
    elsif @channel.change_publisher(@publisher) && params[:force].present?
      respond_with :api, @channel
    else
      respond_with :api, @channel, status: :forbidden
    end
  end
end
