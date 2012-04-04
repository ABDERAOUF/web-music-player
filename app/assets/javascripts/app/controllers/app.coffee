#= require jquery
#= require spine
#= require spine/manager
#= require spine/route

#= require_directory ../helpers

#= require_directory .
#= require_directory ../models

class App extends Spine.Controller
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

    Playlist.fetch()
    Artist.fetch()
    Album.fetch()
    Song.fetch()
    ###

    # TEMP: Temp data, bootstrapped
    Song.refresh([
      { id: 1, name: "Bad", album_id: 1, artist_id: 1 }
      { id: 2, name: "The Way You Make Me Feel", album_id: 1, artist_id: 1 }
      { id: 3, name: "Thriller", album_id: 2, artist_id: 1 }
      { id: 4, name: "Sigh No More", album_id: 3, artist_id: 2 }
      { id: 5, name: "The Cave", album_id: 3, artist_id: 2 }
    ])
    Album.refresh([
      { id: 1, name: "Bad", release_date: "1987", artist_id: 1 }
      { id: 2, name: "Thriller", release_date: "1982", artist_id: 1 }
      { id: 3, name: "Sigh No More", release_date: "2009", artist_id: 2 }
    ])
    Artist.refresh([
      { id: 1, name: "Michael Jackson" }
      { id: 2, name: "Mumford & Sons" }
      { id: 3, name: "The Bloodhound Gang", sprt_name: "Bloodhound Gang, The" }
      { id: 4, name: "Britney Spears" }
      { id: 5, name: "The Chemical Brothers", sort_name: "Chemical Brothers, The" }
      { id: 6, name: "The Crystal Method", sort_name: "Crystal Method, The" }
      { id: 7, name: "D12" }
      { id: 8, name: "David Bowie" }
      { id: 9, name: "David Gray" }
      { id: 10, name: "The Doors", sort_name: "Doors, The" }
      { id: 11, name: "Eminem" }
      { id: 12, name: "Fatboy Slim" }
      { id: 13, name: "Filter" }
      { id: 14, name: "Garbage" }
    ])
    Playlist.refresh([
      { id: 1, name: "Playlist 1", songs: [ 2, 4, 5 ] }
    ])

    # Initialise main controllers
    playlist = Playlist.first()
    new Spine.Manager(
      new ArtistsPage(playlist: playlist),
      new AlbumsPage(playlist: playlist),
      new SongsPage(playlist: playlist),
      new NowPlayingPage(playlist: playlist),
      new PlaylistPage(playlist: playlist))

    Spine.trigger("show:artists:all")

window.App = App