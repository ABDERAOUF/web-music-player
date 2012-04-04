#= require spine
#= require spine/relation

class Playlist extends Spine.Model
  @configure "Playlist",
    "name",
    "songs"

  addSong: (songId) ->
    @songs.push(songId)
    @trigger "song.add"

  addAlbum: (albumId) ->
    album = Album.find albumId
    @trigger "album.add"

  addArtist: (artistId) ->
    artist = Artist.find artistId
    @trigger "artist.add"

  currentSong: -> if @songs and @songs[0] then Song.find(@songs[0]) else null

  play: -> console.log("play")
  stop: -> console.log("stop")
  pause: -> console.log("pause")
  next: -> console.log("next")
  prev: -> console.log("prev")

window.Playlist = Playlist