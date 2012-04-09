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

    @audioControl.bind "songchange", @proxy(@update)
    @audioControl.bind "timeupdate", @proxy(@updateTimeRemaining)

    @routes
      "/now-playing": => @active()

  goToArtists: -> @navigate "/artists"

  activated: ->
    @el.addClass "active"
    @render()

  update: ->
    @item = @audioControl.currentSong?.flatten()
    @render()
    @updateTimeRemaining @audioControl.currentTime()
    this

  updateTimeRemaining: (time) ->
    @$timeRemaining.text Time.from(time)
    this

window.NowPlayingPage = NowPlayingPage