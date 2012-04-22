#= require jquery
#= require spine

#= require handlebars.template

#= require app/models/artist
#= require app/models/album

class AlbumList extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "albums"

  el: "[data-el='albums-page']"

  elements:
    ".album-list": "$albumList"

  events:
    "click .album-list .show-all": "goToAllSongs"
    "click .album-list .show-all-by-artist": "goToSongsByArtist"
    "click .album-list .album": "goToSongsByAlbum"

  constructor: ->
    super

    # For now, updates don't refresh the view
    #Album.bind "refresh", => @update()

    @routes
      "/albums/artist/:artistId": (params) => @showAllByArtist(params.artistId)
      "/albums": => @showAll()

  showAll: ->
    @currentFilter = "all"
    albums = $.map(Album.all(), (album) -> album.flatten())
    albums = albums.sort(Util.sortBy("name", true))
    @render(albums: albums)
    @active()

  showAllByArtist: (artistId) ->
    @currentFilter = "artist"
    artist = Artist.find(artistId)
    albums = $.map(artist.albums().all(), (album) -> album.flatten())
    albums = albums.sort(Util.sortBy("name", true))
    @render(artist: artist, albums: albums)
    @active()

  goToAllSongs: (e) ->
    @navigate "/songs"

  goToSongsByArtist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    @navigate "/songs/artist/#{artistId}"

  goToSongsByAlbum: (e) ->
    albumId = $(e.currentTarget).data("album-id")
    @navigate "/songs/album/#{albumId}"

window.AlbumList = AlbumList