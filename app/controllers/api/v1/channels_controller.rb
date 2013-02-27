module Api
  module V1
    class ChannelsController < ApplicationController
      respond_to :json

      def create
        channel = Channel.create(params[:description], params[:value])
        render channel
      end

    end
  end
end