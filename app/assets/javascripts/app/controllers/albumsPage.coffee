#= require jquery
#= require spine

#= require handlebars.template

#= require app/models/artist
#= require app/models/album

class AlbumsPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "albums"

  elements:
    ".album-list": "$albumList"

  events:
    "click .album-list .show-all": "showAllSongs"
    "click .album-list .show-all-by-artist": "showSongsByArtist"
    "click .album-list .album": "showSongsByAlbum"

  constructor: ->
    super
    Spine.bind "show:albums", => @active()
    Spine.bind "show:albums:all", => @showAll()
    Spine.bind "show:albums:byArtist", (artistId) => @showAllByArtist(artistId)

  update: -> @render(albums: @items, artist: @artist)

  showAll: ->
    @artist = null
    @items = Album.all()
    @update()
    @active()

  showAllByArtist: (artistId) ->
    @artist = Artist.find(artistId)
    @items = @artist.albums().all()
    @update()
    @active()

  showAllSongs: (e) ->
    Spine.trigger "show:songs"

  showSongsByArtist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    Spine.trigger "show:songs:byArtist", artistId

  showSongsByAlbum: (e) ->
    albumId = $(e.currentTarget).data("album-id")
    Spine.trigger "show:songs:byAlbum", albumId

window.AlbumsPage = AlbumsPage