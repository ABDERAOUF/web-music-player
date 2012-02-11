#= require jquery
#= require spine

#= require handlebars.template

#= require app/models/artist

class ArtistsPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "artists"

  elements:
    ".artist-list": "$artistList"

  events:
    "click .artist-list .show-all": "showAllAlbums"
    "click .artist-list .artist": "showAlbumsByArtist"

  constructor: ->
    super
    Artist.bind "refresh", => @showAll()
    Spine.bind "show:artists", => @showAll()

  activate: ->
    @update()
    @el.addClass("active")

  deactivate: ->
    @el.removeClass("active")

  update: -> @render(artists: @items)

  showAll: ->
    @items = Artist.all()
    @active()

  showAllAlbums: (e) ->
    Spine.trigger "show:albums"

  showAlbumsByArtist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    Spine.trigger "show:albums:byArtist", artistId

window.ArtistsPage = ArtistsPage