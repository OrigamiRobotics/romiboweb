jQuery ->
  if gon and gon.controller and gon.controller == 'palettes' and gon.action == 'index'
    url = "/palettes/#{gon.active_palette}?locale=en"
    $.getScript(url)



