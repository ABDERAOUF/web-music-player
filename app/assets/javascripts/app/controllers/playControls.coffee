#= require jquery
#= require spine

#= require handlebars.template

class PlayControls extends Spine.Controller
  el: "[data-el='play-controls']"

  events:
    "click [data-el='play']": "play"
    "click [data-el='pause']": "pause"

  constructor: ->
    super

  play:  -> @audioControl.play()
  pause: -> @audioControl.pause()

window.PlayControls = PlayControls