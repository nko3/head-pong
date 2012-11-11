class Paddle
  constructor: (@x, @y, @width, @height, @socket) ->

  ai: (puck) ->
    distance = @x - puck.x
    @x -= distance/30

module.exports = Paddle