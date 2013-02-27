module Api
  module V1
    class ChannelsController < ApplicationController
      respond_to :json

      def create
        channel = Channel.create(params[:channel])
        respond_with :api, channel, location: nil
      end

    end
  end
end