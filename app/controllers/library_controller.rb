class LibraryController < ApplicationController
  require 'TagLib'

  def index
    album_folder = "//sara/music/Aerosmith/Pandora's Box Disc 1/"

    Library.new.scan(album_folder)
  end
end
