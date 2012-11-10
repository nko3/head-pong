Puck = require('./puck')
Paddle = require('./paddle')

startGame = () ->
  puck = new Puck(100, 100, 3, 3, 30)
  paddle = new Paddle(50, 50, 30, 10, 'blue')
  mainLoop(puck, paddle)

mainLoop = (puck, paddle) ->
  window.requestAnimationFrame ->
    mainLoop(puck, paddle)
  drawBackground()
  paddle.updateFromMouse()
  paddle.draw()
  puck.draw()
  puck.move()

drawBackground = ->
  color = 128
  ctx.fillStyle = "rgb(#{color},#{color},#{color})"
  ctx.fillRect(0,0,canvas.width,canvas.height)

module.exports = startGame