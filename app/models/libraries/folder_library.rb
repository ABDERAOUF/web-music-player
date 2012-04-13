class FolderLibrary
  @@cover_art = "Folder.jpg"

  def scan(location)
    @artists_added = []
    @albums_added = []
    @songs_added = []

    # TODO: Search for mp3s
    song_file = albumFolder + "02 Make It.mp3"

    TagLib::FileRef.open(song_file) do |file|
      process_file(file)
    end
  end

  private

  def process_file(file)
    tag = file.tag

    artist = Artist.find_by_name tag.artist
    if artist.nil?
      artist = Artist.new(:name => tag.artist)
      artist.save
    end

    album = artist.albums.find_by_name tag.album
    if album.nil?
      album = artist.albums.build(:name => tag.album,
                                  :release_date => tag.year)
    else
      album.release_date = tag.year
    end
    album.cover = File.open(cover_art)
    album.save

    song = album.songs.find_by_name tag.title
    if song.nil?
      song ||= album.songs.build(:name => tag.title,
                                  :track_number => tag.track,
                                  :rating => 0,
                                  :play_count => 0)
      song.save
    end
  end
end