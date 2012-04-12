class LibraryController < ApplicationController
  require 'TagLib'
  root = '//sara/music'

  def index
    test_mp3 = '//sara/music/Aerosmith/Pump/10 What It Takes.mp3'
    TagLib::FileRef.open test_mp3 do |file|
      tag = file.tag

      artist_name = tag.artist

      album_name = tag.album
      album_year = tag.year

      song_name = tag.title
      song_track_number = tag.track
      # Store rating and play count separately

      #cover = tag.frame_list('APIC').first
      #cover.picture

      artist = Artist.find_by_name artist_name
      artist ||= Artist.new({ :name => artist_name })
      artist.save
      artist = Artist.find_by_name artist_name

      album = artist.albums.find_by_name album_name
      #album ||= artist.albums.build({ :name => album_name }) #, :album_year => album_year
      album ||= Album.new({ :artist_id => artist.id, :name => album_name })
      album.save

      @song = album.songs.find_by_name song_name
      @song ||= album.songs.build({ :name => song_name })
      @song.save
    end

  end
end
