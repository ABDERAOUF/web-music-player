#= require jquery
#= require spine

#= require app/models/artist
#= require app/models/album
#= require app/models/song
#= require app/models/playlist

#= require handlebars.template
#= require util

class SongList extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "songs"

  el: "[data-el=songs-list]"

  events:
    "click [data-link=add-song]": "addSongToPlaylist"
    "click [data-link=add-album]": "addAlbumToPlaylist"
    "click [data-link=add-artist]": "addArtistToPlaylist"

  constructor: ->
    super

    Song.bind "refresh", @showAll

    Spine.bind "navigate.songs.artist", @showAllByArtist
    Spine.bind "navigate.songs.album", @showAllByAlbum
    Spine.bind "navigate.songs.all", @showAll

  showAll: =>
    songs = $.map(Song.all(), (song) -> song.flatten())
    songs = songs.sort(Util.sortBy("track", true))
    @render(songs: songs)

  showAllByArtist: (artistId) =>
    artist = Artist.find(artistId)
    songs = []
    for album in artist.albums().all()
      for song in album.songs().all()
        songs.push(song.flatten())

    songs = songs.sort(Util.sortBy("name", true))
    @render(songs: songs, filter: artist)

  showAllByAlbum: (albumId) =>
    album = Album.find(albumId)
    songs = $.map(album.songs().all(), (song) -> song.flatten())
    songs = songs.sort(Util.sortBy("track", true))
    @render(songs: songs, filter: album)

  addSongToPlaylist: (e) ->
    songId = $(e.currentTarget).data("song-id")
    @playlist.add(songId)

  addAlbumToPlaylist: (e) ->
    albumId = $(e.currentTarget).data("album-id")
    @playlist.addAlbum(albumId)

  addArtistToPlaylist: (e) ->
    artistId = $(e.currentTarget).data("artist-id")
    @playlist.addArtist(artistId)

window.SongList = SongList