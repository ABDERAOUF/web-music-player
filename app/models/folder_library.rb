class FolderLibrary
  require 'taglib'
  include Rails.application.routes.url_helpers

  COVER_ART = "Folder.jpg"

  def find_new_songs(location)
    songs_processed = []

    Dir.glob(location + "/**/*.mp3").each do |file|
      song = process_file(file)
      songs_processed.push(song) unless song.nil?
    end

    songs_processed
  end

  def process_file(file)
    processed_song = nil

    TagLib::FileRef.open(file) do |file_ref|
      tag = file_ref.tag

      artist = process_artist(tag)
      album = process_album(artist, tag)
      song = process_song(file, album, tag)

      processed_song = song unless song.nil?
    end

    processed_song
  end

  private

  def process_artist(tag)
    artist = Artist.find_by_name tag.artist

    if artist.nil?
      artist = Artist.new(:name => tag.artist)
      artist.save!
    end

    artist
  end

  def process_album(artist, tag)
    params = {:name => tag.album, :year => tag.year}

    album = artist.albums.find_by_name tag.album

    if album.nil?
      album = artist.albums.build(params)
    else
      album.update_attributes(params)
    end

    album.save!
    album
  end

  def process_song(file, album, tag)
    params = {:name => tag.title, :track_number => tag.track}
    dir = File.dirname(file)

    song = album.songs.find_by_name tag.title

    # New or update
    if song.nil?
      song = album.songs.build(params)
    else
      song.update_attributes(params)
    end

    # Attach cover art
    cover = File.open("#{dir}/#{COVER_ART}", "r")
    if cover
      song.album.cover = cover
    end

    # Set song URL
    song.src_url = songs_play_url()

    song.save!
    song
  end
end