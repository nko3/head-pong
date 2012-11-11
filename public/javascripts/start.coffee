mainLoop = () ->
  window.requestAnimationFrame ->
    mainLoop()
  #updateFromMouse() #handled in tracking

  drawBackground()
  paddle1.draw()
  paddle2.draw()
  puck.draw()

animationLoop = () ->
  setTimeout(animationLoop, 1000/30)
  paddle1.updateFrame()
  paddle2.updateFrame()

drawBackground = ->
  color = 128
  ctx.fillStyle = "rgb(#{color},#{color},#{color})"
  ctx.fillRect(0,0,canvas.width,canvas.height)

updateFromMouse = ->
  socket.emit('mouse_pos', mousex)

start = ->
  mainLoop()
  animationLoop()
module.exports = start