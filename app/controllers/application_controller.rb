class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def log_in(user)
    if user.activated
      session[:session_token] = user.reset_session_token!
    else
      flash[:error] = "Please activate your account. Check your e-mail inbox."
      redirect_to new_session_url
    end
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_not_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def check_if_admin
    render text: "Not authorized", status: 403 if !current_user.admin?
  end
end
