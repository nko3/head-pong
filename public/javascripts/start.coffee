mainLoop = () ->
  window.requestAnimationFrame ->
    mainLoop()
  updateFromMouse()

  drawBackground()
  paddle1.draw()
  paddle2.draw()
  puck.draw()

drawBackground = ->
  color = 128
  ctx.fillStyle = "rgb(#{color},#{color},#{color})"
  ctx.fillRect(0,0,canvas.width,canvas.height)

updateFromMouse = ->
  socket.emit('mouse_pos', mousex)

module.exports = mainLoop