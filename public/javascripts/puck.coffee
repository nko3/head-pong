
class Puck
  constructor: (@x, @y, @radius) ->
    @color = 'black'
    socket.on 'puck_pos', (x, y) =>
      @x = x
      @y = y

module.exports = Puck