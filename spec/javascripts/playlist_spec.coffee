#= require jquery

#= require app/models/song
#= require app/models/playlist

describe "Playlist", ->
  playlist = null

  beforeEach ->
    Song.refresh FakeSongs
    Album.refresh FakeAlbums
    Artist.refresh FakeArtists

  describe "add", ->
    songIdToAdd = null

    beforeEach ->
      songIdToAdd = 1
      playlist = new Playlist

    it "should add the song id to the playlist", ->
      playlist.add(songIdToAdd)
      expect(playlist.songs[0]).toBe(songIdToAdd)

    it "should trigger 'song.add' passing the song that was added", ->
      handler = songAdded: ->
      spyOn handler, "songAdded"
      playlist.bind "song.add", handler.songAdded
      playlist.add songIdToAdd
      expect(handler.songAdded).toHaveBeenCalledWith(playlist, Song.find(songIdToAdd))

    it "should throw an exception if the song does not exist", ->
      nonExistantSongId = 9999
      call = -> playlist.add(nonExistantSongId)
      expect(call).toThrow(new Error("Song #{nonExistantSongId} does not exist"))

    it "should be chainable", ->
      expect(playlist.add(songIdToAdd)).toBe(playlist)

  describe "nextSong", ->
    expectedNextSong = null

    beforeEach ->
      expectedNextSong = Song.find(1)
      playlist = new Playlist
        id: 1
        name: "Playlist 1"
        songs: [ 1, 2, 3 ]

    it "should return the next song", ->
      expect(playlist.nextSong().name).toBe(expectedNextSong.name)

    it "should reduce the playlist length", ->
      playlist.nextSong()
      expect(playlist.songs.length).toBe(2)

    it "should remove the song from the playlist", ->
      playlist.nextSong()
      expect($.inArray(expectedNextSong.id, playlist.songs)).toBe(-1)

    it "should return null if the playlist is empty", ->
      playlist.songs = null
      expect(playlist.nextSong()).toBeNull()