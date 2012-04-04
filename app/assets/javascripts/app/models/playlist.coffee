#= require spine
#= require spine/relation

class Playlist extends Spine.Model
  @configure "Playlist",
    "name",
    "songs"

  add: (songId) ->
    throw new Error("Song #{songId} does not exist") unless Song.exists(songId)

    if !@songs?.length then @songs = []
    @songs.push(songId)
    @trigger "song.add", Song.find(songId)
    this

  addAlbum: (albumId) ->
    album = Album.find(albumId)
    @trigger "album.add"

  addArtist: (artistId) ->
    artist = Artist.find(artistId)
    @trigger "artist.add"

  nextSong: ->
    if @songs?.length
      Song.find(@songs.shift())
    else
      null


window.Playlist = Playlist