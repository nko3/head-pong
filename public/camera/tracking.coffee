
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

## actions

$("#trackbutton").on "click", ->
  _stop = !_stop
  requestAnimationFrame(track)

track = ->
  console.log "tracking..."
  requestAnimationFrame(track) unless _stop
  $("#camvideo").objectdetect "all",
    {scaleMin: 3, scaleFactor: 1.1, classifier: objectdetect.frontalface},
    (coords) ->
      if coords[0]
        left = "#{~~(coords[0][0] + coords[0][2] * 1.0/8 + _videoleft)}px"
        top = "#{~~(coords[0][1] + coords[0][3] * 0.8/8 + _videotop)}px"
        $("#coordinates").html("(#{left}, #{top}) - #{coords}")
        $("#tracker").css
          "left": left,
          "top":  top,
          "width": "80px",
          "height": "80px",
          "display": "block"

