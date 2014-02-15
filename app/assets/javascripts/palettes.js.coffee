jQuery ->
    top = $('#leftSideContentBox').height()
    $('#centerContentBox').css('margin-top', "-#{top}px")
    $('#rightSideContentBox').css('margin-top', "-#{top}px")
