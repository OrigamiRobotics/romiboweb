jQuery ->
  if gon? and gon.controller? and gon.controller == 'profiles'
    class AvatarCropper
      constructor: ->
        $('#cropbox').Jcrop
          aspectRatio: 1
          setSelect: [0, 0, 200, 200]
          onSelect: @update
          onChange: @update

    new AvatarCropper()

    update: (coords) =>
      $('#profile_crop_x').val(coords.x)
      $('#profile_crop_y').val(coords.y)
      $('#profile_crop_w').val(coords.w)
      $('#profile_crop_h').val(coords.h)
