#= require jquery
#= require spine

#= require handlebars.template
#= require humanReadable

#= require app/models/playlist

class PlaylistPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "playlist"

  el: "[data-el='playlist-page']"

  elements:
    "[data-el='time-remaining']": "$timeRemaining"

  constructor: ->
    super

    @audioControl.bind "songchange", @proxy(@update)
    @audioControl.bind "timeupdate", @proxy(@updateTimeRemaining)

    @routes
      "/playlist": => @active()

  activated: ->
    @el.addClass "active"
    @render()

  update: ->
    if @audioControl.currentSong
      @item =
        playlist_name: @playlist.name
        now_playing: @audioControl.currentSong.flatten()
        user_queue: []
        auto_queue: []
    else
      @item = null

    @render()
    @updateTimeRemaining @audioControl.currentTime()
    this

  updateTimeRemaining: (time) ->
    @$timeRemaining.text Time.from(time)
    this

window.PlaylistPage = PlaylistPage