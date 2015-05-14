class AlbumsController < ApplicationController
  def new
    @album = Album.new(band_id: params[:band_id])
    render :new
  end

  def create
    # assign id based on band id as well
    @album = Album.new(album_params)
    if @album.save
      flash.now[:notice] = "Album created"
      redirect_to band_url(@album)
    else
      flash.now[:error] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      flash.now[:notice] = "Album updated"
      redirect_to band_url(@album)
    else
      flash.now[:error] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash.now[:notice] = "Album deleted"
    redirect_to band_url(@album.band)
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  private

  def album_params
    params.require(:album).permit(:name, :live, :band_id)
  end
end
