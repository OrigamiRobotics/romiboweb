jQuery ->
  if gon? and gon.controller? and gon.action? and
      gon.controller == 'romiboweb_pages' and gon.action == 'home'
    $('#homeWrapper').height("#{screen.height - 200}px")