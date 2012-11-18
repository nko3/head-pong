Explosion = require('./explosion')
mainLoop = () ->
  window.requestAnimationFrame ->
    mainLoop()

  drawBackground()
  myPaddle.draw()
  otherPaddle.draw()


  for explosion in explosions
    explosion.draw()

motionLoop = () ->
  if position = 'bottom' then puck.move(myPaddle, otherPaddle) else puck.move(otherPaddle, myPaddle)

  setTimeout =>
    motionLoop()
  , 1000/30

animationLoop = () ->
  setTimeout(animationLoop, 1000/20)
  myPaddle.updateFrame()
  otherPaddle.updateFrame()
  for n in [1..4]
    explosions.push(new Explosion(puck.x - 20 + Math.random()*40, puck.y - 20 + Math.random()*40))

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

# updateFromMouse = ->
#   myPaddle.x = mousex
#   socket.emit('mouse_pos', mousex)

start = ->
  mainLoop()
  animationLoop()
  motionLoop()

module.exports = start