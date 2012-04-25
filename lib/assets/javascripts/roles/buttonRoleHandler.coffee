class ButtonRoleHandler extends RoleHandler
  initRole: ($element) ->
    icon = $element.data("button-icon")
    theme = $element.data("button-theme")
    action = $element.data("button-action")

    $element.addClass "ui-button"
    $element.addClass("ui-button-icon ui-button-icon-#{icon}") if icon
    $element.addClass("ui-button-theme-#{theme}") if theme
    $element.on("click", -> Spine.trigger action) if action


window.ButtonRoleHandler = ButtonRoleHandler