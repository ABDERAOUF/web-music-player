class LocalLibrary
  require 'taglib'
  include Rails.application.routes.url_helpers

  COVER_ART = "Folder.jpg"

  def scan(location)
    songs_processed = []

    Dir.glob(location + "/**/*.{ogg,mp3,m4a,wav}").each do |file_name|
      song = process_file(file_name)
      songs_processed.push(song) unless song.nil?
    end

    songs_processed
  end

  def process_file(file_name)
    processed_song = nil

    TagLib::MPEG::File.new(file_name) do |file|
      tag = file.id3v2_tag
    end

    TagLib::FileRef.open(file_name) do |file_ref|
      artist = process_artist(file_ref)
      album = process_album(artist, file_ref, file_name)
      song = process_song(album, file_ref)

      LocalSong.where(:song_id => song.id).first_or_create! do |local_song|
        local_song.location = file_name
      end

      processed_song = song unless song.nil?
    end

    processed_song
  end

  private

  def process_artist(file_ref)
    tag = file_ref.tag
    Artist.where(:name => tag.artist).first_or_create!
  end

  def process_album(artist, file_ref, file)
    tag = file_ref.tag
    dir = File.dirname(file)

    artist.albums.where(:name => tag.album).first_or_create! do |album|
      album.year = (tag.year.to_s == '' || tag.year.to_s == '0') ? nil : tag.year

      # TODO: Better/common way of finding cover art?
      cover_img = "#{dir}/#{COVER_ART}"

      if File.exists?(cover_img) && album.cover_file_size != File.size(cover_img)
        album.cover = File.open(cover_img)
      else
        album.cover = nil
      end

    end
  end

  def process_song(album, file_ref)
    tag = file_ref.tag
    audio_properties = file_ref.audio_properties

    album.songs.where(:name => tag.title).first_or_create! do |song|
      song.genre = tag.genre
      song.track_number = tag.track
      song.length = audio_properties.length
    end
  end
end