Puck = require('./puck')

startGame = () ->
  puck = new Puck(100, 100, 3, 3, 30)
  mainLoop(puck)

mainLoop = (puck) ->
  window.requestAnimationFrame ->
    mainLoop(puck)
  drawBackground()
  puck.draw()
  puck.move()

drawBackground = ->
  color = 128
  ctx.fillStyle = "rgb(#{color},#{color},#{color})"
  ctx.fillRect(0,0,canvas.width,canvas.height)

module.exports = startGame