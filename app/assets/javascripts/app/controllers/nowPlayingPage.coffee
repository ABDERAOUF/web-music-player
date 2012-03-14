#= require jquery
#= require spine

#= require handlebars.template

class NowPlayingPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "now-playing"

  el: "[data-el='now-playing']"

  events:
    "click nav [data-nav='artists']": "goToArtists"

  constructor: ->
    super
    currentSong = @playlist.currentSong()
    @render(song: currentSong, album: currentSong.album(), artist: currentSong.artist())

    Spine.bind "show:now-playing", => @active()
    @playlist.bind "next-song", (songId) =>
      song = Song.find(songId)
      @render(song: song, album: song.album(), artist: song.album().artist())

  goToArtists: -> Spine.trigger "show:artists"

window.NowPlayingPage = NowPlayingPage