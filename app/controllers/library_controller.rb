class LibraryController < ApplicationController

  def index
    album_folder = "//sara/Music/Michael Jackson"

    @songs_processed = LocalLibrary.new.scan(album_folder)
  end
end
