window.URL = window.URL || window.webkitURL;

getUserMedia = (options, success, error) ->
  getUserMedia = window.navigator.getUserMedia || window.navigator.mozGetUserMedia || window.navigator.webkitGetUserMedia || (options, success, error) -> error()
  getUserMedia.call(window.navigator, options, success, error)

hasGetUserMedia = ->
  navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia

not_supported = ->
  show_msg "We're using cool stuff, so you need to move to a decent browser, like chrome."

if hasGetUserMedia
  getUserMedia { video: true }, got_camera, fallback
else
  not_supported

got_camera = (stream) ->
  alert "ok!"
  $("video").src = window.URL.createObjectURL(stream)

fallback = (e) ->
  alert "err: #{e}"
  show_msg "Not able to connect with your camera device, did you authorized us?"

show_msg = (message) ->
  $("#message").html message