#= require spine
#= require spine/relation

class Playlist extends Spine.Model
  @configure "Playlist",
    "name",
    "songs"

  addSong: (songId) ->
  addAlbum: (albumId) ->
  addArtist: (artistId) ->

window.Playlist = Playlist