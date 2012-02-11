#= require spine
#= require spine/relation

class Song extends Spine.Model
  @configure "Song",
    "name",
    "sort_name"

  @belongsTo "album", "Album"

window.Song = Song