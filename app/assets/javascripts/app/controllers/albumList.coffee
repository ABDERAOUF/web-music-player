#= require jquery
#= require spine

#= require app/models/artist
#= require app/models/album

#= require handlebars.template

class AlbumList extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "albums"

  el: "[data-el=albums-list]"

  events:
    "click [data-link=all-songs]": "goToAllSongs"
    "click [data-link=songs-by-artist]": "goToSongsByArtist"
    "click [data-link=songs-by-album]": "goToSongsByAlbum"

  constructor: ->
    super

    Album.bind "refresh", @showAll

    Spine.bind "navigate.albums.artist", @showAllByArtist
    Spine.bind "navigate.albums", @showAll

  showAll: =>
    @currentFilter = "all"
    albums = $.map(Album.all(), (album) -> album.flatten())
    albums = albums.sort(Util.sortBy("name", true))
    @render(albums: albums)

  showAllByArtist: (artistId) =>
    @currentFilter = "artist"
    artist = Artist.find(artistId)
    albums = $.map(artist.albums().all(), (album) -> album.flatten())
    albums = albums.sort(Util.sortBy("name", true))
    @render(artist: artist, albums: albums)

  goToAllSongs: (e) ->
    @navigate "/songs"

  goToSongsByArtist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    @navigate "/songs/artist/#{artistId}"

  goToSongsByAlbum: (e) ->
    albumId = $(e.currentTarget).data("album-id")
    @navigate "/songs/album/#{albumId}"

window.AlbumList = AlbumList