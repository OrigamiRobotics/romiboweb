jQuery ->
  if gon and gon.controller and gon.controller == 'palettes' and gon.action == 'index'
    url = "/palettes/#{gon.first_palette}?locale=en"
    $.getScript(url)

    $(document).bind "keypress", (e) ->
      if e.keycode == 13
        url = "/buttons"
        data =
          palette_id: gon.first_palette
          keypress: true
          js: true

        $.ajax
          type: "POST",
          url: url,
          data: data
          dataType: 'script'

