class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params)
    if user
      log_in(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = "Invalid email/password combination"
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    @current_user.reset_session_token! if @current_user
    @current_user = nil
    session[:session_token] = nil
    redirect_to new_user_url
  end
end
