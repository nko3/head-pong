class Paddle
  constructor: (@x, @y, @width, @height, @color) ->

  updateFromMouse: ->
    @x = mousex || @x

  updateFromComputer: ->

  draw: ->
    ctx.fillStyle = @color
    ctx.fillRect(@x - @width/2, @y - @height/2 , @width, @height)


module.exports = Paddle