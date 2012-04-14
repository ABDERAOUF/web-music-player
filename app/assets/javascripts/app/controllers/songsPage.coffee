#= require jquery
#= require spine

#= require handlebars.template
#= require util

#= require app/models/artist
#= require app/models/album
#= require app/models/song

class SongsPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "songs"

  el: "[data-el='songs-page']"

  elements:
    ".song-list": "$songList"

  events:
    "click .song-list .song": "addSongToPlaylist"
    "click .song-list .add-whole-album": "addAlbumToPlaylist"
    "click .song-list .add-whole-artist": "addArtistToPlaylist"

  constructor: ->
    super

    @routes
      "/songs/artist/:artistId": (params) => @showAllByArtist(params.artistId)
      "/songs/album/:albumId": (params) => @showAllByAlbum(params.albumId)
      "/songs": => @showAll()


  showAll: ->
    @item = $.map(Song.all(), (song) -> song.flatten())
    @item = @item.sort(Util.sortBy("track", true))
    @render(songs: @item)
    @active()

  showAllByArtist: (artistId) ->
    artist = Artist.find(artistId)
    @item = []
    for album in artist.albums().all()
      for song in album.songs().all()
        @item.push(song.flatten())

    @item = @item.sort(Util.sortBy("name", true))

    @render(songs: @item, filter: artist)
    @active()

  showAllByAlbum: (albumId) ->
    album = Album.find(albumId)
    @item = $.map(album.songs().all(), (song) -> song.flatten())
    @item = @item.sort(Util.sortBy("track", true))
    @render(songs: @item, filter: album)
    @active()

  addSongToPlaylist: (e) ->
    songId = $(e.currentTarget).data("song-id")
    @playlist.add(songId)

  addAlbumToPlaylist: (e) ->
    albumId = $(e.currentTarget).data("album-id")
    @playlist.addAlbum(albumId)

  addArtistToPlaylist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    @playlist.addArtist(artistId)

window.SongsPage = SongsPage