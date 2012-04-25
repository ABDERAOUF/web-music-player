#= require jquery
#= require spine
#= require spine/manager

#= require_directory ./controllers
#= require_directory ./models

#= require ./router
#= require roles/roles
#= require roles/buttonRoleHandler
#= require roles/listRoleHandler

class App extends Spine.Controller
  el: "[data-el='stage']"

  constructor: ->
    super

    roles = new RoleCollection()
    roles
      .add("button", new ButtonRoleHandler())
      .add("list", new ListRoleHandler())
      .initRoles(@el)

    Spine.bind "rendered", (c) -> c.el.initRoles()

    window.onbeforeunload = ->
      if Spine.Ajax.pending
        '''Data is still being sent to the server;
           you may lose unsaved changes if you close this page.'''

    # TODO: Get playlist from server as well
    playlist = Playlist.first() || new Playlist(name: "Playlist")
    audioControl = new Html5AudioControl()

    # Initialise main pages
    new Spine.Manager(
      new LibraryLists(playlist: playlist),
      new PlaylistPage(playlist: playlist, audioControl: audioControl),
      new NowPlayingPage(audioControl: audioControl))

    # Initialise components
    new PlayControls(audioControl: audioControl)

    songFeeder = new SongFeeder(playlist, audioControl)
    songFeeder.start()

    Router.get().setup()

    #Playlist.fetch()
    Artist.fetch()
    Album.fetch()
    Song.fetch()

window.App = App