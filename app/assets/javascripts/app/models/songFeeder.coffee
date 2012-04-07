#= require spine

class SongFeeder extends Spine.Module
  #@extend Events

  constructor: (playlist, audio) ->
    super

    @playlist = playlist
    @audioControl = audio

    @audioControl.bind "ended", @proxy(@nextSong)
    @audioControl.bind "abort, error", @proxy(@nextSong)

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

window.SongFeeder = SongFeeder