#= require jquery
#= require spine

#= require handlebars.template

#= require app/models/artist

class ArtistsPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "artists"

  el: "[data-el='artists-page']"

  elements:
    ".artist-list": "$artistList"

  events:
    "click .artist-list .show-all": "showAllAlbums"
    "click .artist-list .artist": "showAlbumsByArtist"

  constructor: ->
    super
    Artist.bind "refresh", => @update()

    @routes
      "/artists": => @showAll()

  update: ->
    @item = Artist.all() || []
    @item = @item.sort(Util.sortBy("name", true))
    @render()

  showAll: -> @active()

  showAllAlbums: (e) ->
    @navigate "/albums"

  showAlbumsByArtist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    @navigate "/albums/artist/#{artistId}"

window.ArtistsPage = ArtistsPage