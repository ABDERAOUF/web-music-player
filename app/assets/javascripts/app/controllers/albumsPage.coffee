#= require jquery
#= require spine

#= require handlebars.template

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
    Spine.bind "show:albums", => @showAll()
    Spine.bind "show:albums:byArtist", (artistId) => @showAllByArtist(artistId)

  activate: ->
    @update()
    @el.addClass("active")

  deactivate: ->
    @el.removeClass("active")

  update: -> @render(albums: @items)

  showAll: ->
    @items = Album.all()
    @active

  showAllByArtist: (artistId) ->
    @items = Album.findAllByAttribute("artist_id", artistId)
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