class LibraryController < ApplicationController

  def index
    album_folder = "//sara/Music"

    @songs_processed = LocalLibrary.new.scan(album_folder)
  end
end
