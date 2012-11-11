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


## actions

$("#camerabutton").on "click", ->
  init_camera()

$("#stopbutton").on "click", ->
  _video.get(0).pause()
  _stream.stop()

## handlers

process = (stream) ->
  _video = $("#camvideo")
  _video.attr "src", URL.createObjectURL(stream);
  _stream = stream

fallback = (e) ->
  show_msg "Not able to connect with your camera device, did you authorized us? #{e}"

not_supported = ->
  show_msg "We're using cool stuff, so you need to move to a decent browser, like Chrome."

show_msg = (message) ->
  alert(message)

## init

init_camera = ->
  _stream = null
  getUserMedia { video: true, audio: false },
    (mediaStream) -> process(mediaStream),
    (error) -> fallback(error)

not_supported unless hasGetUserMedia()
init_camera()
