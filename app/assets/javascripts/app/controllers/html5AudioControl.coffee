#= require jquery
#= require spine

#= require app/models/playlist
#= require app/models/song

class Html5AudioControl extends Spine.Controller
  tag: "audio"

  constructor: ->
    super

    $("body").append(@el)
    @audio = @el.get(0)

    @currentSong = null

  play: ->
    @audio.play()
    @trigger "play"

  pause: ->
    @audio.pause()
    @trigger "pause"

  stop: ->
    @audio.pause()
    @trigger "stop"

  setSong: (song) ->
    @currentSong = song
    @el.attr "src", song.url

window.Html5AudioControl = Html5AudioControl