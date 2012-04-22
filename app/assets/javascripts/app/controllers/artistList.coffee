#= require jquery
#= require spine

#= require handlebars.template
#= require iscroll

#= require app/models/artist

class ArtistList extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "artists"

  el: "[data-el='artists-page']"

  elements:
    "[data-role=content]": "$content"
    ".artist-list": "$artistList"

  events:
    "click .artist-list .show-all": "goToAllAlbums"
    "click .artist-list .artist": "goToAlbumsByArtist"

  constructor: ->
    super

    # For now, updates don't refresh the view
    Artist.bind "refresh", => @showAll()

    @routes
      "/artists": => @showAll()

  showAll: ->
    artists = Artist.all() || []
    artists = artists.sort(Util.sortBy("name", true))
    @render(artists: artists)
    @scroller?.destroy()
    setTimeout (=> @scroller = new iScroll(@$content.get(0), vScrollbar: true)), 0
    @active()

  goToAllAlbums: (e) ->
    @navigate "/albums"

  goToAlbumsByArtist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    @navigate "/albums/artist/#{artistId}"

window.ArtistList = ArtistList