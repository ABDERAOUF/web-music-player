#= require handlebars

#= require app/models/artist
#= require app/models/album
#= require app/models/song

Handlebars.registerHelper "song_page_title", ->
  if this.filter instanceof Artist
    "Songs by #{this.filter.name}"
  else if this.filter instanceof Album
    "#{this.filter.artist().name} - #{this.filter.name}"
  else
    "All Songs"

Handlebars.registerHelper "add_to_playlist_item", ->
  if this.filter instanceof Artist
    c = "add-whole-artist"
    label = "Add all songs by #{this.filter.name} to playlist"
    data = "data-artist-id=\"#{this.filter.id}\""
  else if this.filter instanceof Album
    c = "add-whole-album"
    label = "Add whole album to playlist"
    data = "data-album-id=\"#{this.filter.id}\""
  else
    return ""

  "<li class=\"ui-content-list-item #{c}\"#{data}>#{label}</li>"