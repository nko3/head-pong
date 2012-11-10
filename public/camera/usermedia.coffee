URL = window.URL || window.webkitURL;

getUserMedia = (options, success, error) ->
  getUserMedia = navigator.getUserMedia || navigator.mozGetUserMedia || navigator.webkitGetUserMedia || (options, success, error) -> error()
  getUserMedia.call(navigator, options, success, error)

hasGetUserMedia = ->
  navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia

if hasGetUserMedia
  getUserMedia { video: true },
    (x) -> got_camera(x),
    (e) -> fallback(e)
else
  not_supported

got_camera = (stream) ->
  $("#camvideo").attr "src", window.URL.createObjectURL(stream);

fallback = (e) ->
  alert "err: #{e}"
  show_msg "Not able to connect with your camera device, did you authorized us?"

not_supported = ->
  show_msg "We're using cool stuff, so you need to move to a decent browser, like chrome."

show_msg = (message) ->
  $("#message").html message