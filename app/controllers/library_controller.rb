class LibraryController < ApplicationController

  def index
    album_folder = "//sara/music/Aerosmith"

    local = LocalLibrary.new
    local.delay.process_folder(album_folder)
  end
end
