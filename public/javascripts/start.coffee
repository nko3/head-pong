mainLoop = () ->
  window.requestAnimationFrame ->
    mainLoop()
  drawBackground()
  paddle1.updateFromMouse()
  paddle1.draw()
  paddle2.updateFromComputer()
  paddle2.draw()
  puck.draw()
  puck.move()

drawBackground = ->
  color = 128
  ctx.fillStyle = "rgb(#{color},#{color},#{color})"
  ctx.fillRect(0,0,canvas.width,canvas.height)

module.exports = mainLoop