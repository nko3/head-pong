#intended API: constructor, move, x, y, dx, dy
Puck = require('../shared/puck')

class ServerPuck extends Puck
  constructor: (@radius) ->
    @_reset()

  _reset: ->
    @x = global.canvas_width/2
    @y = global.canvas_height/2
    @dx = Math.random()*20 - 10
    @dy = Math.random()*20 - 10
    #make sure it's not super slow
    if Math.abs(@dy) < 1 then @dy *= 10
    if Math.abs(@dy) < 5 then @dy *= 2

module.exports = ServerPuck