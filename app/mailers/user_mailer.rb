class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to the Poor Man's Itunes!")
  end
end
