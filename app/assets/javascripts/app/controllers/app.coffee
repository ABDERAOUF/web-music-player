#= require jquery
#= require spine
#= require spine/manager
#= require spine/route

#= require_directory ../helpers

#= require_directory .
#= require_directory ../models

class App extends Spine.Controller
  el: "[data-el='stage']"

  constructor: ->
    super

    ###
    Spine.bind "rendered", (c) -> c.el.initRoles()
    @el.initRoles()

    window.onbeforeunload = ->
      # TODO: Get from resource
      if Spine.Ajax.pending
        '''Data is still being sent to the server;
           you may lose unsaved changes if you close this page.'''

    ###

    playlist = Playlist.first() || new Playlist(name: "Playlist")
    audioControl = new Html5AudioControl()

    # Initialise main pages
    new Spine.Manager(
      new ArtistsPage(playlist: playlist),
      new AlbumsPage(playlist: playlist),
      new SongsPage(playlist: playlist),
      new PlaylistPage(playlist: playlist, audioControl: audioControl),
      new NowPlayingPage(audioControl: audioControl))

    # Initialise components
    new PlayControls(audioControl: audioControl)

    songFeeder = new SongFeeder(playlist, audioControl)
    songFeeder.start()

    @routes
      "/": => @navigate "/now-playing"
    Spine.Route.setup()

    #Playlist.fetch()
    Artist.fetch()
    Album.fetch()
    Song.fetch()

window.App = App