#= require spine
#= require spine/ajax
#= require spine/relation

class Artist extends Spine.Model
  @configure "Artist",
    "name",
    "sort_name"

  @extend Spine.Model.Ajax

  @hasMany "albums", "Album"
  @hasMany "songs", "Song"

window.Artist = Artist