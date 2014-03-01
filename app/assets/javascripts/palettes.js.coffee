jQuery ->
  top = $('#leftSideContentBox').height()
  $('#centerContentBox').css('margin-top', "-#{top}px")
  $('#rightSideContentBox').css('margin-top', "-#{top}px")

  alert("alertt");
  console.log(gon)

  if gon and gon.controller and gon.controller == 'palettes' and gon.action == 'index'
    console.log(gon)
    url = "/palettes/#{gon.first_palette}?locale=en"
    $.getScript(url)
