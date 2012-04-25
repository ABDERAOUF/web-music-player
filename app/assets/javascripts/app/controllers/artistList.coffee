#= require jquery
#= require spine

#= require app/models/artist

#= require handlebars.template

class ArtistList extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "artists"

  el: "[data-el=artists-list]"

  events:
    "click [data-link=all-albums]": "goToAllAlbums"
    "click [data-link=albums-by-artist]": "goToAlbumsByArtist"

  constructor: ->
    super

    Artist.bind "refresh", @showAll

    Spine.bind "navigate.artists.all", @showAll

  showAll: =>
    artists = Artist.all() || []
    artists = artists.sort(Util.sortBy("name", true))
    @render(artists: artists)

  goToAllAlbums: (e) ->
    @navigate "/albums"

  goToAlbumsByArtist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    @navigate "/albums/artist/#{artistId}"

window.ArtistList = ArtistList