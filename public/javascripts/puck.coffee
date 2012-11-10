canvas_stuff = require('./canvas')
canvas = canvas_stuff.canvas
ctx = canvas_stuff.ctx

class Puck
  constructor: (@x, @y, @dx, @dy, @radius, @color) ->


  move: ->
    @x += @dx
    @y += @dy

    if this.x < @radius || this.x > canvas.width - @radius
      this.dx *= -1
    if this.y < @radius || this.y > canvas.height - @radius
      this.dy *= -1

    if this.x < @radius then this.x = @radius
    if this.x > canvas.width - @radius then this.x = canvas.width - @radius
    if this.y < @radius then this.y = @radius
    if this.y > canvas.height - @radius then this.y = canvas.height - @radius

  draw: (ctx, fillStyle = @color, shadow = false) ->
      ctx.fillStyle = fillStyle;
      ctx.beginPath()
      ctx.arc(@x, @y, @radius, 0, Math.PI * 2, false)
      ctx.fill()

module.exports = Puck