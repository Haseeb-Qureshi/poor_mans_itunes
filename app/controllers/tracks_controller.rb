class TracksController < ApplicationController
  before_action :redirect_if_not_logged_in

  def new
    @track = Track.new(album_id: params[:album_id])
    render :new
  end

  def create
    #assign album ID based on ID as well
    @track = Track.new(track_params)
    if @track.save
      flash[:notice] = "Track created"
      redirect_to track_url(@track)
    else
      flash.now[:error] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(album_params)
      flash[:notice] = "Track updated"
      redirect_to band_url(@track)
    else
      flash.now[:error] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    flash[:notice] = "Track deleted"
    redirect_to album_url(@track.album)
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  private

  def track_params
    params.require(:track).permit(:title, :bonus, :lyrics, :album_id)
  end
end
