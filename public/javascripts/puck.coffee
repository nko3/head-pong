Puck = require('../../lib/shared/puck')

class ClientPuck extends Puck
  constructor: (@x, @y, @radius) ->
    @color = 'black'
    socket.on 'puck_pos', (x, y, dx, dy) =>
      @x = x
      @y = y
      @dx = dx
      @dy = dy

  _reset: ->

module.exports = ClientPuck