#= require jquery
#= require spine

#= require handlebars.template

class NowPlayingPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "now-playing"

  el: "[data-el='now-playing-page']"

  events:
    "click nav [data-nav='artists']": "goToArtists"

  constructor: ->
    super

    Spine.bind "show:now-playing", => @active()
    @playlist.bind "next-song", (songId) =>
      song = Song.find(songId)
      @render(song: song, album: song.album(), artist: song.album().artist())

  goToArtists: -> Spine.trigger "show:artists"

  activated: ->
    @el.addClass "active"
    currentSong = @audio.currentSong
    if currentSong then @render song: currentSong, album: currentSong.album(), artist: currentSong.artist()

window.NowPlayingPage = NowPlayingPage