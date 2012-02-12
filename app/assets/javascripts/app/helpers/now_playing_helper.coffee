#= require handlebars

Handlebars.registerHelper "released_date", (date) ->
  "Released #{date}"