#= require jquery
#= require spine

#= require iscroll

class ListRoleHandler extends RoleHandler
  initRole: ($element) ->
    @scroller = @create($element)

    $element.bind "rendered", =>
      $element
        .find("[data-list-container]")
        .addClass("ui-list")
        .find("[data-list-item]")
        .addClass("ui-list-item")

      @scroller = @create($element)

  create: ($element) ->
    #if @scroller
      #@scroller.destroy()
    if $element.children().length
      @scroller = new iScroll($element[0])

window.ListRoleHandler = ListRoleHandler