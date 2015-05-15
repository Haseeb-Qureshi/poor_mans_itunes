class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in, only: :show
  before_action :check_if_admin, only: [:index, :make_admin]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.activation_token = User.generate_activation_token
    if @user.save
      UserMailer.activation_email(@user).deliver
      flash[:notice] = "Please activate your account. Check your e-mail inbox."
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def index
    @users = User.all
    render :index
  end

  def make_admin
    User.find(params[:user_id]).toggle(:admin).save
    flash[:notice] = "Admin rights granted"
    redirect_to users_url
  end
end
