#= require jquery
#= require spine

#= require handlebars.template

class NowPlaying extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "now-playing"

window.NowPlaying = NowPlaying