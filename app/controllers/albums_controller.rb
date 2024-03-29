class AlbumsController < ApplicationController
  def index
    albums = Album.all()
    respond_with albums.to_json(:methods => [:cover_url])
  end

  def create
    album = Album.build(params[:album])
    album.save
    respond_with album
  end

  def show
    album = Album.find(params[:id])
    respond_with album
  end

  def update
    album = Album.find(params[:id])
    album.update_attributes(params[:album])
    respond_with album
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy
    respond_with :status => :ok
  end

  def songs
    album = Album.find(params[:id])
    respond_with album.songs
  end

end
