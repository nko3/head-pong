Puck = require('./puck')

startGame = (ctx) ->
  puck = new Puck(100, 100, 0, 0, 30, 'black')
  puck.draw(ctx)

module.exports = startGame