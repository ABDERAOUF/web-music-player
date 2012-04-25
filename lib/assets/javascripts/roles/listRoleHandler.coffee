#= require jquery
#= require spine

#= require iscroll

class ListRoleHandler extends RoleHandler
  initRole: ($element) ->
    @scroller = @create($element) if $element.children().length

    $element.bind "rendered", =>
      $element
        .find("[data-list-container")
          .addClass("ui-list")
          .end()
        .find("[data-list-item]")
          .addClass("ui-list-item")

      @scroller = @create($element) unless @scroller
      setTimeout((=> @scroller.refresh()), 100)

  create: ($element) ->
    @scroller = new iScroll($element[0])

window.ListRoleHandler = ListRoleHandler