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
  else
    c = "show-all"
    label = "All Songs"
    count = Song.count()

  "<li class=\"#{c}\">#{label}<span class=\"count\">#{count} Songs</span></li>"