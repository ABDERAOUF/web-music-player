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


  update: -> @render(songs: @items, filter: @filter)

  showAll: ->
    @filter = null
    @items = Song.all()
    @update()
    @active()

  showAllByArtist: (artistId) ->
    @filter = Artist.find(artistId)
    @items = @filter.songs().all()
    @update()
    @active()

  showAllByAlbum: (albumId) ->
    @filter = Album.find(albumId)
    @items = @filter.songs().all()
    @update()
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