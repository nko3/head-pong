
## Vars
_video = _stream = null

## Browser Compatibility

URL = window.URL || window.webkitURL;

getUserMedia = (options, success, error) ->
  getUserMedia = navigator.getUserMedia || navigator.mozGetUserMedia || navigator.webkitGetUserMedia || (options, success, error) -> error()
  getUserMedia.call(navigator, options, success, error)

hasGetUserMedia = ->
  navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia

## init
not_supported unless hasGetUserMedia

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
  console.log "ye"
  _video = $("#camvideo")
  _stream = stream
  console.log "umm"
  _video.attr "src", window.URL.createObjectURL(_stream);

fallback = (e) ->
  alert "err: #{e}"
  show_msg "Not able to connect with your camera device, did you authorized us?"

not_supported = ->
  show_msg "We're using cool stuff, so you need to move to a decent browser, like chrome."

show_msg = (message) ->
  $("#message").html message
