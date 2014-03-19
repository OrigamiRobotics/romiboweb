jQuery ->
  if gon and gon.controller and gon.controller == 'palettes' and gon.action == 'index'
    $("#palette_link_#{gon.active_palette}").click()



