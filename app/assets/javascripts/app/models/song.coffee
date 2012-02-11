#= require spine
#= require spine/relation

class Song extends Spine.Model
  @configure "Song",
    "name"

  @belongsTo "album", "Album"

window.Song = Song