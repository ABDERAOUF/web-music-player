#= require spine
#= require spine/relation

class Artist extends Spine.Model
  @configure "Artist",
    "name",
    "sort_name"

  @hasMany "albums", "Album"
  @hasMany "songs", "Song"

window.Artist = Artist