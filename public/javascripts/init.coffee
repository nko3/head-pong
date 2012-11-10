Puck = require('./puck')

startGame = (canvas, ctx) ->
  puck = new Puck(100, 100, 3, 3, 30, canvas, ctx)
  mainLoop(puck)

mainLoop = (puck) ->
  window.requestAnimationFrame ->
    mainLoop(puck)
  puck.draw()
  puck.move()

module.exports = startGame