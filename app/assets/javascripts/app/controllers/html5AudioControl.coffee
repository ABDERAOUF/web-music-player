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

    # TEMP
    @audio.controls = true

    @audio.addEventListener "ended", @proxy(@e_ended)
    @audio.addEventListener "timeupdate", @proxy(@e_timeUpdate)
    @audio.addEventListener "abort", @proxy(@e_abort)
    @audio.addEventListener "error", @proxy(@e_error)


  play: ->
    @audio.play()
    @trigger "play"
    this

  pause: ->
    @audio.pause()
    @trigger "pause"
    this

  stop: ->
    @audio.pause()
    @trigger "stop"
    this

  isPaused: ->
    @audio.paused

  setSong: (song) ->
    @currentSong = song
    @el.attr "src", song.src_url unless !song
    @trigger "songchange", song
    this

  currentTime: ->
    @audio.currentTime

  e_ended:      (e) -> @trigger "ended"
  e_timeUpdate: (e) -> @trigger "timeupdate", @audio.currentTime
  e_abort:      (e) -> @trigger "abort"
  e_error:      (e) -> @trigger "error"

window.Html5AudioControl = Html5AudioControl