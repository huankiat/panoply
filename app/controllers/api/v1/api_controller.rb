class Api::V1::APIController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_json
  respond_to :json

  private

  def not_found_json
    render :json => "", :status => :not_found and return
  end
end