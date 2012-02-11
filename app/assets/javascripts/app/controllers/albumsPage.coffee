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
    "click .album-list .show-all": "showAll"
    "click .album-list .album": "showSongs"

  constructor: ->
    super
    Spine.bind "show:albums", (artistId) =>
      @items = if artistId then Album.findAllByAttribute("artist_id", artistId) else Album.all()
      @active()

  activate: ->
    @update()

  update: ->
    @render(albums: @items)

  showAll: -> Spine.trigger "show:songs"

  showSongs: (e) ->
    albumId = $(e.currentTarget).data("album-id")
    Spine.trigger "show:songs", albumId

window.AlbumsPage = AlbumsPage