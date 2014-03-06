jQuery ->
  if gon and gon.controller and gon.controller == 'palettes' and gon.action == 'index'
    url = "/palettes/#{gon.first_palette}?locale=en"
    $.getScript(url)

    $(document).bind "keypress", (e) ->
      link =  $("#addNewButton")
      if link.length
        link.trigger "click"  if e.which is 13


