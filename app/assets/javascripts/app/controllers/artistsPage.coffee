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
    "click .artist-list .show-all": "goToAllAlbums"
    "click .artist-list .artist": "goToAlbumsByArtist"

  constructor: ->
    super

    # For now, updates don't refresh the view
    #Artist.bind "refresh", => @update()

    @routes
      "/artists": => @showAll()

  showAll: ->
    artists = Artist.all() || []
    artists = artists.sort(Util.sortBy("name", true))
    @render(artists: artists)
    @active()

  goToAllAlbums: (e) ->
    @navigate "/albums"

  goToAlbumsByArtist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    @navigate "/albums/artist/#{artistId}"

window.ArtistsPage = ArtistsPage