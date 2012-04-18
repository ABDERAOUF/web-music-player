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

  def played
    song = Song.find(params[:id])
    song.played
    respond_with song
  end

  def download
    song = Song.find(params[:id])
    local_song = LocalSong.find_by_song_id song.id
    send_file local_song.location, :type => "audio/mp3"
  end
end
