#= require jquery
#= require spine

#= require handlebars.template

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
    Spine.bind "show:songs:byArtist", (artistId) => @showallByArtist(artistId)

  activate: ->
    @update()
    @el.addClass("active")

  deactivate: ->
    @el.removeClass("active")

  update: -> @render(songs: @items)

  showAll: ->
    @items = Song.all()
    @active()

  showAllByArtist: (artistId) ->
    @items = Song.findAllByAttribute("artist_id", artistId)
    @activate()

  showAllByAlbum: (albumId) ->
    @items = Song.findAllByAttribute("album_id", albumId)
    @activate()


window.SongsPage = SongsPage