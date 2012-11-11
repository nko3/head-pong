Explosion = require('./explosion')
class Puck
  constructor: (@x, @y, @radius) ->
    @color = 'black'
    socket.on 'puck_pos', (x, y) =>
      @x = x
      @y = y
      explosion = new Explosion(@x - 20 + Math.random()*40, @y - 20 + Math.random()*40)
      explosions.push(explosion)

  draw: (fillStyle = @color) ->
    ctx.fillStyle = fillStyle;
    ctx.beginPath()
    ctx.arc(@x, @y, @radius, 0, Math.PI * 2, false)
    ctx.fill()

module.exports = Puck