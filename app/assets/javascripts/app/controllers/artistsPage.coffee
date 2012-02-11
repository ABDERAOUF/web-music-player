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
    "click .artist-list .show-all": "showAll"
    "click .artist-list .artist": "showAlbums"

  constructor: ->
    super
    Artist.bind "refresh", => @update()
    Spine.bind "show:artists", => @active()

  activate: ->
    @update()

  update: ->
    @render(artists: Artist.all())

  showAll: -> Spine.trigger "show:albums"

  showAlbums: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    Spine.trigger "show:albums", artistId

window.ArtistsPage = ArtistsPage