class BandsController < ApplicationController
  before_action :redirect_if_not_logged_in
  
  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:notice] = "Band created"
      redirect_to band_url(@band)
    else
      flash.now[:error] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      flash[:notice] = "Band updated"
      redirect_to band_url(@band)
    else
      flash.now[:error] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    flash[:notice] = "Band deleted"
    redirect_to bands_url
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
