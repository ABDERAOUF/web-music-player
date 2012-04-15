class LocalSongsController < ApplicationController
  def download
    local_song = LocalSong.find(params[:id])

    send_file local_song.location, :type => "audio/mp3"
  end
end
