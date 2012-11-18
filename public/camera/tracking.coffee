
## compatibility hacks

URL = window.URL || window.webkitURL

requestAnimationFrame = (callback, element) ->
  requestAnimationFrame =
    window.requestAnimationFrame || window.webkitRequestAnimationFrame ||
    window.mozRequestAnimationFrame || window.oRequestAnimationFrame ||
    (callback, element) ->
      currTime = new Date().getTime()
      timeToCall = Math.max(0, 16 - (currTime - lastTime))
      id = window.setTimeout ->
        callback(currTime + timeToCall)
      ,
      timeToCall

      lastTime = currTime + timeToCall
      return id

  requestAnimationFrame.call(window, callback, element);

## video coordinates
_videoleft = $("#camvideo").offset().left
_videotop = $("#camvideo").offset().top
_stop = true

smoother = new Smoother(0.85, [0, 0, 0, 0, 0])

video = $("#camvideo")
canvas = $("#pong")


## actions

$("#trackbutton").on "click", ->
  init_tracking()

## handlers

track = ->
  if video.readyState == video.HAVE_ENOUGH_DATA
    $("#camvideo").objectdetect "all",
      {scaleMin: 3, scaleFactor: 1.1, classifier: objectdetect.frontalface},
      (coords) ->
        if coords[0]
          coords = smoother.smooth(coords[0]);
          #console.log coords
          left = ~~(coords[0] + coords[2] * 1.0/8 + $(video).offset().left)
          top = ~~(coords[1] + coords[3] * 0.8/8 + $(video).offset().top)
          width = ~~(coords[2] * 6/8)
          height = ~~(coords[3] * 6/8)

          canvas_width = $(canvas).width() + $(canvas).offset().left
          send_coordinates(canvas_width - 340 - 1.7*(left - $(video).offset().left), top)
          #console.log "left: #{left}, canvas: #{canvas_width}, offset: #{$(video).offset().left}"

          $("#tracker").css
            "left":    ($(video).width() - left - width) + "px",
            "top":     (top) + "px",
            "width":   width + "px",
            "height":  height + "px",
            "display": "none" #"block"
        else
          hide_tracker()

  setTimeout(track, 100) unless _stop

send_coordinates = (x, y) ->
  socket.emit('mouse_pos', x)
  myPaddle.x = x
  $("#coordinates").html("(#{x}, #{y})")

hide_tracker = ->
  $("#tracker").css
    "display": "none"

## init

init_tracking = ->
  _stop = !_stop
  requestAnimationFrame(track)
  if _stop
    hide_tracker()

init_tracking()
