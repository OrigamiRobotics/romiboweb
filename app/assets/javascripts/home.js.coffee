jQuery ->
  if gon? and gon.controller? and gon.action? and
      gon.controller == 'romiboweb_pages' and gon.action == 'home'
    $('#homeWrapper').height("#{screen.height - 200}px")
    $('.input').css('width', '80%')
    $('.form-horizontal .controls').css('margin-left', '0')

    $('.form-horizontal .control-label').css
      width: '100%'
      'padding-top': '5px'
      'text-align': 'center'
      'margin-top': '-5px'
