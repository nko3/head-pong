mainLoop = () ->
  window.requestAnimationFrame ->
    mainLoop()
  updateFromMouse()


  drawBackground()
  paddle1.draw()
  paddle2.draw()
  puck.draw()
  console.log('explosions: ' + explosions)
  for explosion in explosions
    explosion.draw()

animationLoop = () ->
  setTimeout(animationLoop, 1000/15)
  paddle1.updateFrame()
  paddle2.updateFrame()
  for explosion in explosions
    explosion.updateFrame()
  i = 0
  while i < explosions.length
    explosion = explosions[i]
    if explosion.currentFrame < explosion.totalFrames
      i++
    else
      explosions.splice(i, 1)

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