class Api::V1::ChannelsController < Api::V1::APIController

  def index
    authenticate_user!
    if params[:filter] == 'owner'
      @channels = Channel.where('owner_id = ?', current_user.id)
    else
      @channels = Channel.where('owner_id = ? OR assignee_id = ?', current_user.id, current_user.id)
    end
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
    authenticate_user!
    @channel = Channel.find(params[:id])
    @publisher = Spreadsheet.find(params[:channel][:spreadsheet_id])

    if params[:force] == 'true'
      if @channel.change_publisher(current_user, @publisher)
        @channel.update_attributes(params[:channel])
        respond_with :api, @channel, status: '200'
      else
        respond_with :api, @channel, status: '403'
      end
    elsif params[:force] == 'false'
      if @channel.publisher == @publisher
        @channel.update_attributes(params[:channel])
        respond_with :api, @channel
      else
        respond_with :api, @channel, status: '409'
      end
    end
  end
end
