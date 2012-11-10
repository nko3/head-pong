

class Paddle
  constructor: (@x, @y, @width, @height, @color) ->

  updateFromMouse: ->
    @x = mousex || @x

  draw: ->
    ctx.fillStyle = @color
    ctx.fillRect(@x - @width/2, @y - @width/2, @width, @height)



module.exports = Paddle