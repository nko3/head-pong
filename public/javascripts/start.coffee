mainLoop = () ->
  window.requestAnimationFrame ->
    mainLoop()
  paddle1.updateFromMouse()
  puck.move()


  drawBackground()
  paddle1.draw()
  paddle2.draw()
  puck.draw()

drawBackground = ->
  color = 128
  ctx.fillStyle = "rgb(#{color},#{color},#{color})"
  ctx.fillRect(0,0,canvas.width,canvas.height)

module.exports = mainLoop