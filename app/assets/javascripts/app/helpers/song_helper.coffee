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

    
