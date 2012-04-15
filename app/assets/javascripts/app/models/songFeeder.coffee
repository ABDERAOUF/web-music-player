#= require spine

class SongFeeder extends Spine.Module
  #@extend Events

  constructor: (playlist, audio) ->
    super

    @playlist = playlist
    @playlist.bind "song.added", => @nextSongIfEmpty()

    @audioControl = audio
    @audioControl.bind "ended", => @nextSong()
    @audioControl.bind "abort, error", => @nextSong()

  start: -> @nextSong()

  nextSong: ->
    nextSong = @playlist.nextSong()

    if nextSong
      @playlistEmpty = false
      @audioControl.setSong nextSong
      @audioControl.play()
    else
      @playlistEmpty = true

    this

  nextSongIfEmpty: ->
    @nextSong() unless @audioControl.currentSong

window.SongFeeder = SongFeeder