class Puck
  constructor: (@x, @y, @radius) ->
    @color = 'black'

  draw: (fillStyle = @color) ->
    ctx.fillStyle = fillStyle;
    ctx.beginPath()
    ctx.arc(@x, @y, @radius, 0, Math.PI * 2, false)
    ctx.fill()

module.exports = Puck