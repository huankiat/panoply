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

  def followers
    @broadcast = Broadcast.find(params[:id])
    @users = User.all - @broadcast.followers
    respond_with @broadcast, @users
  end

  def add_followers
    @broadcast = Broadcast.find(params[:id])
    redirect_to channels_path and return unless @broadcast
    follower_ids = params[:broadcast][:follower_ids]
    follower_ids.delete('')
    follower_ids.each do |id|
      user = User.find(id)
      @broadcast.add_follower(user) if user
    end
    redirect_to channels_path, notice: 'Users added to broadcast.'
  end

end