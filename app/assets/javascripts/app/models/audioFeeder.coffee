#= require spine

class AudioFeeder extends Spine.Module
  #@extend Events

  constructor: ->
    super

    #@audio.bind "songFinished", @proxy(@nextSong)

  nextSong: ->
    song = @playlist.nextSong
    @audio.setSong song

window.AudioFeeder = AudioFeeder