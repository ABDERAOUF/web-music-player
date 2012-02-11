#= require jquery
#= require spine

#= require handlebars.template

#= require app/models/artist
#= require app/models/album
#= require app/models/song

class SongsPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "songs"

  elements:
    ".song-list": "$songList"

  events:
    "click .song-list .song": "addToQueue"

  constructor: ->
    super

    Spine.bind "show:songs", => @showAll()
    Spine.bind "show:songs:byAlbum", (albumId) => @showAllByAlbum(albumId)
    Spine.bind "show:songs:byArtist", (artistId) => @showAllByArtist(artistId)

  activate: ->
    @render(songs: @items, filter: @filter)
    @el.addClass("active")

  deactivate: ->
    @el.removeClass("active")

  showAll: ->
    @filter = null
    @items = Song.all()
    @active()

  showAllByArtist: (artistId) ->
    @filter = Artist.find(artistId)
    @items = @filter.songs().all()
    @active()

  showAllByAlbum: (albumId) ->
    @filter = Album.find(albumId)
    @items = @filter.songs().all()
    @active()


window.SongsPage = SongsPage