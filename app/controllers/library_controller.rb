class LibraryController < ApplicationController

  def index
    album_folder = "//sara/music/Aerosmith"

    @new_songs = FolderLibrary.new.find_new_songs(album_folder)
  end
end
