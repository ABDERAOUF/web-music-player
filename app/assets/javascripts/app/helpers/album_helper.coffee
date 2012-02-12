#= require handlebars

#= require app/models/artist
#= require app/models/album
#= require app/models/song

Handlebars.registerHelper "album_page_title", ->
  if this.artist
    "Albums by #{this.artist.name}"
  else
    "All Albums"

Handlebars.registerHelper "all_songs_item", ->
  if this.artist
    c = "show-all-by-artist"
    label = "All Songs by #{this.artist.name}"
    count = this.artist.songs().all().length
    data = " data-artist-id=\"#{this.artist.id}\""
  else
    c = "show-all"
    label = "All Songs"
    count = Song.count()
    data = ""

  "<li class=\"ui-content-list-item #{c}\"#{data}><p class=\"caption\">#{label}</p><p class=\"count\">#{count} Songs</p></li>"