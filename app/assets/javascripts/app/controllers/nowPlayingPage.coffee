#= require jquery
#= require spine

#= require handlebars.template

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
    currentSong = @audioControl.currentSong
    if currentSong then @render song: currentSong, album: currentSong.album(), artist: currentSong.artist()
    @updateTimeRemaining @audioControl.currentTime()

  updateTimeRemaining: (time) ->
    time = Math.floor(time || 0)
    date = new Date(time * 1000)

    minutes = ("0" + date.getMinutes()).slice(-2)
    seconds = ("0" + date.getSeconds()).slice(-2)

    @$timeRemaining.text "#{minutes}:#{seconds}"

window.NowPlayingPage = NowPlayingPage