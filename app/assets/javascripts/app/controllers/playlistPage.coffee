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

    @playlist.bind "song.added", => @update()
    @audioControl.bind "songchange", => @update()
    @audioControl.bind "timeupdate", (time) => @updateTimeRemaining(time)

    Spine.bind "playlist.navigate", => @active()

  activate: ->
    @el.addClass("active")
    @render()

  update: ->
    @render
      playlist_name: @playlist.name
      now_playing: @audioControl.currentSong?.flatten()
      user_queue: $.map(@playlist.userQueue(), (song) -> song.flatten())
      auto_queue: $.map(@playlist.autoQueue(), (song) -> song.flatten())

    @updateTimeRemaining @audioControl.currentTime()
    this

  updateTimeRemaining: (time) ->
    @$timeRemaining.text Time.from(time)
    this

window.PlaylistPage = PlaylistPage