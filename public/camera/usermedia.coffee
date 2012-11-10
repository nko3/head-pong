
shimGetUserMedia = ->
  navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia

not_supported = ->
  $("#message").html("We're using cool stuff, so you need to move to a decent browser, like chrome.")

if shimGetUserMedia
  shimGetUserMedia {video: true, audio:true}, (media_stream) ->
    alert "got it"
  ,
  not_available

not_available = ->
  $("#message").html("Not able to connect with your camera device, did you authorized us?")

//
  handle_device = stream ->
    alert "just got the stream!"