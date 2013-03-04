class LandingPagesController < ApplicationController

  respond_to :html

  def home
    @signup = Signup.new
  end

  def signup
    @signup = Signup.new(params[:signup])
    respond_with @signup do |format|
      if @signup.save
        flash[:notice] = 'Thanks for signing up!'
        format.html { redirect_to root_url }
      else
        format.html { render 'home' }
      end
    end
  end

end