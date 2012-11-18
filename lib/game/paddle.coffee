class Paddle
  constructor: (@x, @y, @width, @height) ->

  ai: (puck) ->
    distance = @x - puck.x
    @x -= distance/10

module.exports = Paddle