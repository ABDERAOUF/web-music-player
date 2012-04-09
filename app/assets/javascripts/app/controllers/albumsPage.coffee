#= require jquery
#= require spine

#= require handlebars.template

#= require app/models/artist
#= require app/models/album

class AlbumsPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "albums"

  el: "[data-el='albums-page']"

  elements:
    ".album-list": "$albumList"

  events:
    "click .album-list .show-all": "showAllSongs"
    "click .album-list .show-all-by-artist": "showSongsByArtist"
    "click .album-list .album": "showSongsByAlbum"

  constructor: ->
    super

    @routes
      "/albums/artist/:artistId": (params) => @showAllByArtist(params.artistId)
      "/albums": => @showAll()

  showAll: ->
    @item = $.map(Album.all(), (album) -> album.flatten())
    @render(albums: @item)
    @active()

  showAllByArtist: (artistId) ->
    artist = Artist.find(artistId)
    @item = $.map(artist.albums().all(), (album) -> album.flatten())
    @render(artist: artist, albums: @item)
    @active()

  showAllSongs: (e) ->
    @navigate "/songs"

  showSongsByArtist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    @navigate "/songs/artist/#{artistId}"

  showSongsByAlbum: (e) ->
    albumId = $(e.currentTarget).data("album-id")
    @navigate "/songs/album/#{albumId}"

window.AlbumsPage = AlbumsPage