#= require jquery
#= require spine

#= require handlebars.template

KEY_PREVIOUS   = 177
KEY_PLAY_PAUSE = 179
KEY_NEXT       = 176

class PlayControls extends Spine.Controller
  el: "[data-el='play-controls']"

  events:
    "click [data-el='play']": "play"
    "click [data-el='pause']": "pause"

  constructor: ->
    super

    $("body").on "keyup", @proxy(@e_keyup)

  play:   -> @audioControl.play()
  pause:  -> @audioControl.pause()
  toggle: -> if @audioControl.isPaused() then @audioControl.play() else @audioControl.pause()

  e_keyup: (e) ->
    switch e.which
      #when KEY_PREVIOUS then @previous()
      when KEY_PLAY_PAUSE then @toggle()
      #when KEY_NEXT then @next()

window.PlayControls = PlayControls