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

    # For now, updates don't refresh the view
    #Song.bind "refresh", => @update()

    @routes
      "/songs/artist/:artistId": (params) => @showAllByArtist(params.artistId)
      "/songs/album/:albumId": (params) => @showAllByAlbum(params.albumId)
      "/songs": => @showAll()


  showAll: ->
    songs = $.map(Song.all(), (song) -> song.flatten())
    songs = songs.sort(Util.sortBy("track", true))
    @render(songs: songs)
    @active()

  showAllByArtist: (artistId) ->
    artist = Artist.find(artistId)
    songs = []
    for album in artist.albums().all()
      for song in album.songs().all()
        songs.push(song.flatten())

    songs = songs.sort(Util.sortBy("name", true))

    @render(songs: songs, filter: artist)
    @active()

  showAllByAlbum: (albumId) ->
    album = Album.find(albumId)
    songs = $.map(album.songs().all(), (song) -> song.flatten())
    songs = songs.sort(Util.sortBy("track", true))
    @render(songs: songs, filter: album)
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