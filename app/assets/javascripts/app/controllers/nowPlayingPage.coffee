#= require jquery
#= require spine

#= require handlebars.template
#= require humanReadable

class NowPlayingPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "now-playing"

  el: "[data-el='now-playing-page']"

  elements:
    "[data-el='time-remaining']": "$timeRemaining"

  events:
    "click nav [data-nav='artists']": "goToArtists"

  constructor: ->
    super

    @audioControl.bind "songchange", (song) => @update(song)
    @audioControl.bind "timeupdate", (time) => @updateTimeRemaining(time)

    @routes
      "/now-playing": => @active()

  goToArtists: -> @navigate "/artists"

  activate: ->
    @el.addClass("active")
    @render()

  update: (song) ->
    @item = song.flatten()
    @render()
    @updateTimeRemaining @audioControl.currentTime()
    this

  updateTimeRemaining: (time) ->
    @$timeRemaining.text Time.from(time)
    this

window.NowPlayingPage = NowPlayingPage