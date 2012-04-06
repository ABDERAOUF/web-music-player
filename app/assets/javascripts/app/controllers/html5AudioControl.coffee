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
    @el.attr "src", song.url unless !song
    @trigger "songchange", song

  currentTime: ->
    @audio.currentTime

  e_ended: (e) ->
    console.log "ended"
    @trigger "ended"

  e_timeUpdate: (e) ->
    @trigger "timeupdate", @audio.currentTime

window.Html5AudioControl = Html5AudioControl