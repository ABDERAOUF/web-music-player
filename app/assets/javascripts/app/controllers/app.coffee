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

    Playlist.fetch()
    Artist.fetch()
    Album.fetch()
    Song.fetch()
    ###

    # TEMP: Temp data, bootstrapped
    Song.refresh([
      { id: 1, name: "Bad", album_id: 1, artist_id: 1, rating: 4 }
      { id: 2, name: "The Way You Make Me Feel", album_id: 1, artist_id: 1 }
      { id: 3, name: "Thriller", album_id: 2, artist_id: 1 }
      { id: 4, name: "Sigh No More", album_id: 3, artist_id: 2 }
      { id: 5, name: "The Cave", album_id: 3, artist_id: 2 }
      # Wrong URL on purpose
      { id: 6, name: "Till The World Ends", album_id: 4, artist_id: 4, url: "/music/01 - Till The World Ends.mp1" }
      { id: 7, name: "Hold It Against Me", album_id: 4, artist_id: 4, rating: 4, url: "/music/02 - Hold It Against Me.mp3" }
      { id: 8, name: "Inside Out", album_id: 4, artist_id: 4, rating: 5, url: "/music/03 - Inside Out.mp3" }
      { id: 9, name: "I Wanna Go", album_id: 4, artist_id: 4, rating: 2, url: "/music/04 - I Wanna Go.mp3" }
      { id: 10, name: "How I Roll", album_id: 4, artist_id: 4, url: "/music/05 - How I Roll.mp3" }
      { id: 11, name: "(Drop Dead) Beautiful (feat. Sabi)", album_id: 4, artist_id: 4, url: "/music/06 - (Drop Dead) Beautiful (feat. Sabi).mp3" }
      { id: 12, name: "Seal It With A Kiss", album_id: 4, artist_id: 4, url: "/music/07 - Seal It With A Kiss.mp3" }
      { id: 13, name: "Big Fat Bass (feat. Will.I.Am)", album_id: 4, artist_id: 4, url: "/music/08 - Big Fat Bass (feat. Will.I.Am).mp3" }

    ])
    Album.refresh([
      { id: 1, name: "Bad", release_date: "1987", artist_id: 1 }
      { id: 2, name: "Thriller", release_date: "1982", artist_id: 1 }
      { id: 3, name: "Sigh No More", release_date: "2009", artist_id: 2 }
      { id: 4, name: "Femme Fatale", artist_id: 4 }
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
      { id: 1, name: "Playlist 1", user_queue: [ 6, 7, 8, 9, 10 ] }
    ])

    playlist = Playlist.first()
    audioControl = new Html5AudioControl()

    # Initialise main controllers
    new Spine.Manager(
      new ArtistsPage(playlist: playlist),
      new AlbumsPage(playlist: playlist),
      new SongsPage(playlist: playlist),
      new NowPlayingPage(audioControl: audioControl),
      new PlaylistPage(playlist: playlist, audioControl: audioControl))

    # Initialise component controllers
    new PlayControls(audioControl: audioControl)

    songFeeder = new SongFeeder(playlist, audioControl)
    songFeeder.start()

    Spine.Route.setup()

window.App = App