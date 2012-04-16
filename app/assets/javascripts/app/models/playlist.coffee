#= require spine
#= require spine/ajax
#= require spine/relation

class Playlist extends Spine.Model
  @configure "Playlist",
    "name",
    "currently_playing",
    "user_queue",
    "auto_queue"

  @extend Spine.Model.Ajax

  add: (song) ->
    if song not instanceof Song
      throw new Error("Song #{song} does not exist") unless Song.exists(song)
      song = Song.find(song)

    if !@user_queue?.length then @user_queue = []

    @user_queue.push(song.id)
    @trigger "song.added", song
    song.played()
    this

  addAlbum: (album) ->
    if album not instanceof Album
      throw new Error("Album #{album} does not exist") unless Album.exists(album)
      album = Album.find(album)

    for song in album.songs().all()
      do (song) ->
        @add(song)

    @trigger "album.added", album
    this

  addArtist: (artist) ->
    if artist not instanceof Artist
      throw new Error("Artist #{artist} does not exist") unless Artist.exists(artist)
      artist = Artist.find(artist)

    for song in artist.songs().all()
      do (song) ->
        @add(song)

    @trigger "artist.added"
    this

  nextSong: ->
    if @user_queue?.length
      @currently_playing = Song.find(@user_queue.shift())
    else
      null

  currentlyPlaying: ->
    @currently_playing

  userQueue: ->
    if @user_queue?.length
      $.map @user_queue, (songId) -> Song.find(songId)
    else
      []

  autoQueue: ->
    if @auto_queue?.length
      $.map @auto_queue, (songId) -> Song.find(songId)
    else
      []

window.Playlist = Playlist