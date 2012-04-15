class ArtistsController < ApplicationController
  def index
    respond_with Artist.all()
  end

  def create
    artist = Artist.build(params[:artist])
    artist.save
    respond_with artist
  end

  def show
    artist = Artist.find(params[:id])
    respond_with artist
  end

  def update
    artist = Artist.find(params[:id])
    artist.update_attributes(params[:artist])
    respond_with artist
  end

  def destroy
    artist = Artist.find(params[:id])
    artist.destroy
    respond_with :status => :ok
  end

  def albums
    artist = Artist.find(params[:id])
    respond_with artist.albums
  end

  def songs
    # TODO: Artist no longer has_many songs, need to go through the albums
    #artist = Artist.find(params[:id])
    #respond_with artist.songs
  end

end
