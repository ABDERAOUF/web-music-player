class FolderLibrary
  require 'taglib'

  COVER_ART = "Folder.jpg"

  def find_new_songs(location)
    songs_added = []

    Dir.glob(location + "/**/*.mp3").each do |file|
      new_song = process_file(file)
      songs_added.push(new_song) unless new_song.nil?
    end

    songs_added
  end

  def process_file(file)
    new_song = nil

    TagLib::FileRef.open(file) do |file_ref|
      tag = file_ref.tag
      artist = process_artist(tag)
      album = process_album(artist, tag)

      dir = File.dirname(file)

      song = process_song(dir, album, tag)

      new_song = song unless song.nil?
    end

    new_song
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
    params = {:name => tag.album,
              :release_date => tag.year}

    album = artist.albums.find_by_name tag.album

    if album.nil?
      album = artist.albums.build(params)
    else
      album.update_attributes(params)
    end

    album.save!
    album
  end

  def process_song(dir, album, tag)
    params = {:name => tag.title,
              :track_number => tag.track}

    song = album.songs.find_by_name tag.title

    if song.nil?
      song ||= album.songs.build(params)
    else
      song.update_attributes(params)
    end

    song.album.cover = File.open("#{dir}/#{COVER_ART}", "r")
    song.save!
    song
  end
end