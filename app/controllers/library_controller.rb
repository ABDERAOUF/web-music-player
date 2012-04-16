class LibraryController < ApplicationController

  def index
    album_folder = "//sara/Music/Aerosmith"

    @songs_processed = LocalLibrary.new.find_new_songs(album_folder)
  end
end
