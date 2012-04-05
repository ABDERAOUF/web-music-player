#= require app/controllers/html5AudioControl

describe "Html5AudioControl", ->
  audioControl = null

  beforeEach ->
    audioControl = new Html5AudioControl

  it "should have an 'audio' element", ->
    expect(audioControl.el.get(0).nodeName.toLowerCase()).toBe("audio")

  describe "play", ->

    it "should 'play' the audio control", ->
      spyOn audioControl.audio, "play"
      audioControl.play()
      expect(audioControl.audio.play).toHaveBeenCalled()

    it "should trigger 'play'", ->
      handler = play: ->
      spyOn handler, "play"
      audioControl.bind "play", handler.play
      audioControl.play()
      expect(handler.play).toHaveBeenCalled()

    it "should set the 'src' if it is null", ->
      audioControl.el.attr("src", "")

    it "should get the next song if 'currentSong' is null", ->
      audioControl.currentSong = null


  describe "pause", ->

    it "should 'pause' the audio control", ->
      spyOn audioControl.audio, "pause"
      audioControl.pause()
      expect(audioControl.audio.pause).toHaveBeenCalled()

    it "should trigger 'pause'", ->
      handler = pause: ->
      spyOn handler, "pause"
      audioControl.bind "pause", handler.pause
      audioControl.pause()
      expect(handler.pause).toHaveBeenCalled()

  describe "stop", ->

    it "should 'pause' the audio control", ->
      spyOn audioControl.audio, "pause"
      audioControl.pause()
      expect(audioControl.audio.pause).toHaveBeenCalled()

    it "should trigger 'stop'", ->
      handler = stop: ->
      spyOn handler, "stop"
      audioControl.bind "stop", handler.stop
      audioControl.stop()
      expect(handler.stop).toHaveBeenCalled()

    it "should rewind the song to the start", ->
      expect(true).toBeFalsy()
