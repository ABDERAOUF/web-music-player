#= require jquery
#= require spine

#= require handlebars.template

#= require app/models/artist
#= require app/models/album
#= require app/models/song

class SongsPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "songs"

  el: "[data-el='songs-page']"

  elements:
    ".song-list": "$songList"

  events:
    "click .song-list .song": "addSongToPlaylist"
    "click .song-list .add-whole-album": "addAlbumToPlaylist"
    "click .song-list .add-whole-artist": "addArtistToPlaylist"

  constructor: ->
    super

    @routes
      "/songs/artist/:artistId": (params) => @showAllByArtist(params.artistId)
      "/songs/album/:albumId": (params) => @showAllByAlbum(params.albumId)
      "/songs": => @showAll()


  showAll: ->
    @item = Song.all()
    @render(songs: @item)
    @active()

  showAllByArtist: (artistId) ->
    artist = Artist.find(artistId)
    @item = artist.songs().all()
    @render(songs: @item, filter: artist)
    @active()

  showAllByAlbum: (albumId) ->
    album = Album.find(albumId)
    @item = album.songs().all()
    @render(songs: @item, filter: album)
    @active()

  addSongToPlaylist: (e) ->
    songId = $(e.currentTarget).data("song-id")
    @playlist.add(songId)

  addAlbumToPlaylist: (e) ->
    albumId = $(e.currentTarget).data("album-id")
    @playlist.addAlbum(albumId)

  addArtistToPlaylist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    @playlist.addArtist(artistId)

window.SongsPage = SongsPage