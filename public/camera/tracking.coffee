
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

## actions

$("#trackbutton").on "click", ->
  _stop = !_stop
  requestAnimationFrame(track)

track = ->
  requestAnimationFrame(track) unless _stop
  video = $("#camvideo")
  if video.readyState == video.HAVE_ENOUGH_DATA
    $("#camvideo").objectdetect "all",
      {scaleMin: 3, scaleFactor: 1.1, classifier: objectdetect.frontalface},
      (coords) ->
        if coords[0]
          coords = smoother.smooth(coords[0]);
          #console.log coords
          left = "#{~~(coords[0][0] + coords[0][2] * 1.0/8 + _videoleft)}px"
          top = "#{~~(coords[0][1] + coords[0][3] * 0.8/8 + _videotop)}px"
          $("#coordinates").html("(#{~~coords[0]}, #{~~coords[1]})")
          $("#tracker").css
            "left":    ~~(coords[0] + coords[2] * 1.0/8 + $(video).offset().left) + "px",
            "top":     ~~(coords[1] + coords[3] * 0.8/8 + $(video).offset().top) + "px",
            "width":   ~~(coords[2] * 6/8) + "px",
            "height":  ~~(coords[3] * 6/8) + "px",
            "display": "block"
        else
          $("#tracker").css
            "display": "none"


