class ActivationsController < ApplicationController
  def edit
    user = User.find_by(activation_token: params[:activation_token])
    if user
      user.toggle(:activated).save
      log_in(user)
      flash[:notice] = "Thanks for verifying your e-mail!"
      redirect_to bands_url
    else
      flash[:error] = "Invalid token"
      redirect_to new_user_url
    end
  end
end
