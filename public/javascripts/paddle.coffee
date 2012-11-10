class Paddle
  constructor: (@x, @y, @width, @height, @color) ->

  updateFromMouse: ->
    @x = mousex || @x

  updateFromComputer: ->

  draw: ->
    ctx.fillStyle = @color
    ctx.fillRect(@x, @y , @width, @height)


module.exports = Paddle