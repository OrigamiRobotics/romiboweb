jQuery ->
  top = $('#leftSideContentBox').height()
  $('#centerContentBox').css('margin-top', "-#{top}px")
  $('#rightSideContentBox').css('margin-top', "-#{top}px")

  if gon and gon.controller and gon.controller == 'palettes' and gon.action == 'index'
    url = "/palettes/#{gon.first_palette}?locale=en"
    $.getScript(url)
