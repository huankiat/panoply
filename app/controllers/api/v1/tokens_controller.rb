class Api::V1::TokensController < Api::V1::APIController
  skip_before_filter :verify_authenticity_token

  def create
    if params[:email] && params[:password]  # regular login
      user = User.find_for_database_authentication(email: params[:email])
      raise ActiveRecord::RecordNotFound unless user
      render nothing: true, status: 401 and return unless user.valid_password?(params[:password])
    end

    user.ensure_authentication_token! if user
    respond_with(user, only: [:id, :email, :authentication_token], location: nil)
  end

  def destroy
    user = User.find_by_email!(params[:email])
    respond_with(user.reset_authentication_token!)
  end

end