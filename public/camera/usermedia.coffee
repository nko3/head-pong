## vars
_video = _stream = null

## compatibility hacks

URL = window.URL || window.webkitURL

hasGetUserMedia = ->
  navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia

getUserMedia = (options, success, error) ->
  getUserMedia = navigator.getUserMedia || navigator.mozGetUserMedia || navigator.webkitGetUserMedia ||
    (options, success, error) -> error()
  getUserMedia.call(navigator, options, success, error)

## init
not_supported unless hasGetUserMedia()

## actions

$("#camerabutton").on "click", ->
  _stream = null
  getUserMedia { video: true, audio: false },
    (x) -> got_camera(x),
    (e) -> fallback(e)

$("#stopbutton").on "click", ->
  _video.get(0).pause()
  _stream.stop()

## handlers

got_camera = (stream) ->
  _video = $("#camvideo")
  _video.attr "src", URL.createObjectURL(stream);
  _stream = stream

fallback = (e) ->
  alert "err: #{e}"
  show_msg "Not able to connect with your camera device, did you authorized us?"

not_supported = ->
  show_msg "We're using cool stuff, so you need to move to a decent browser, like chrome."

show_msg = (message) ->
  $("#message").html message
