#= require spine
#= require spine/relation

class Artist extends Spine.Model
  @configure "Artist",
    "name"

  @hasMany "albums", "Album"

window.Artist = Artist