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
      song = process_song(album, tag)

      new_song = song unless song.nil?
    end

    new_song
  end

  private

  def process_artist(tag)
    artist = Artist.find_by_name tag.artist
    if artist.nil?
      artist = Artist.new(:name => tag.artist)
      artist.save
    end
    artist
  end

  def process_album(artist, tag)
    album = artist.albums.find_by_name tag.album
    if album.nil?
      album = artist.albums.build(:name => tag.album,
                                  :release_date => tag.year)
    else
      album.release_date = tag.year
    end
    album.cover = File.open(COVER_ART)
    album.save
  end

  def process_song(album, tag)
    song = album.songs.find_by_name tag.title
    if song.nil?
      song ||= album.songs.build(:name => tag.title,
                                 :track_number => tag.track,
                                 :rating => 0,
                                 :play_count => 0)
      song.save
    else
      nil
    end
  end
end