class LocalLibrary
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

  def process_file(file_name)
    processed_song = nil

    TagLib::FileRef.open(file_name) do |file_ref|
      tag = file_ref.tag

      artist = process_artist(tag)
      album = process_album(artist, tag)
      song = process_song(file_name, album, tag)

      params = {:location => file_name}

      local_song = LocalSong.find_by_song_id song.id
      if local_song.nil?
        local_song = LocalSong.new(params)
      else
        local_song.update_attributes(params)
      end
      local_song.song.src_url = local_song_url
      local_song.save!

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

    song.save!
    song
  end
end