#= require spine

class AudioFeeder extends Spine.Module
  #@extend Events

  constructor: (playlist, audio) ->
    super

    @playlist = playlist
    @audioControl = audio

    @audioControl.bind "ended", @proxy(@nextSong)

    @audioControl.setSong @playlist.nextSong()

  nextSong: ->
    song = @playlist.nextSong
    @audioControl.setSong song

window.AudioFeeder = AudioFeeder