class LibraryController < ApplicationController
  require 'TagLib'

  def index
    albumFolder = "//sara/music/Aerosmith/Pandora's Box Disc 1/"
    cover_art = albumFolder + "Folder.jpg"
    song_file = albumFolder + "02 Make It.mp3"

    TagLib::FileRef.open song_file do |file|
      tag = file.tag

      artist = Artist.find_by_name tag.artist
      artist ||= Artist.new(:name => tag.artist)
      artist.save

      album = artist.albums.find_by_name tag.album
      album ||= artist.albums.build(:name => tag.album,
                                    :release_date => tag.year)
      album.cover = File.open(cover_art)
      album.save

      @song = album.songs.find_by_name tag.title
      @song ||= album.songs.build(:name => tag.title,
                                  :track_number => tag.track,
                                  :rating => 0,
                                  :play_count => 0)
      @song.save
    end

  end
end
