class SongsController < ApplicationController
  def index
    respond_with Song.all()
  end

  def create
    song = Song.build(params[:song])
    song.save
    respond_with song
  end

  def show
    song = Song.find(params[:id])
    respond_with song
  end

  def update
    song = Song.find(params[:id])
    song.update_attributes(params[:song])
    respond_with song
  end

  def destroy
    song = Song.find(params[:id])
    song.destroy
    respond_with :status => :ok
  end


end
