class LocalLibrary
  require 'taglib'
  include Rails.application.routes.url_helpers

  COVER_ART = "Folder.jpg"

  def scan(location)
    songs_processed = []

    Dir.glob(location + "/**/*.{ogg,mp3,m4a,wav}").each do |file|
      song = process_file(file)
      songs_processed.push(song) unless song.nil?
    end

    songs_processed
  end

  def process_file(file_name)
    processed_song = nil

    TagLib::FileRef.open(file_name) do |file_ref|
      tag = file_ref.tag

      artist = process_artist(tag)
      album = process_album(artist, tag, file_name)
      song = process_song(album, tag)

      local_song = LocalSong.where(:song_id => song.id).first_or_create do |local_song|
        local_song.location = file_name
      end

      # TODO: How best to handle this requirement?
      song.src_url = "local-songs/#{local_song.id}/download"
      song.save!

      processed_song = song unless song.nil?
    end

    processed_song
  end

  private

  def process_artist(tag)
    Artist.where(:name => tag.artist).first_or_create
  end

  def process_album(artist, tag, file)
    dir = File.dirname(file)

    artist.albums.where(:name => tag.album).first_or_create do |album|
      album.year = (tag.year.to_s == '' || tag.year.to_s == '0') ? nil : tag.year

      # TODO: Better/common way of finding cover art?
      cover_img = "#{dir}/#{COVER_ART}"

      album.cover = File.exists?(cover_img) ? File.open(cover_img) : nil
    end
  end

  def process_song(album, tag)
    album.songs.where(:name => tag.title).first_or_create do |song|
      song.genre = tag.genre
      song.track_number = tag.track
    end
  end
end