#= require spine
#= require spine/relation

class Playlist extends Spine.Model
  @configure "Playlist",
    "name",
    "songs"

  addSong: (songId) -> songs.push(songId)
  addAlbum: (albumId) ->
  addArtist: (artistId) ->

  currentSong: -> if @songs and @songs[0] then Song.find(@songs[0]) else null

  play: -> console.log("play")
  stop: -> console.log("stop")
  pause: -> console.log("pause")
  next: -> console.log("next")
  prev: -> console.log("prev")

window.Playlist = Playlist