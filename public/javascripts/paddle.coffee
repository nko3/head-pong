class Paddle
  constructor: (@x, @y, @width, @height, @color) ->
    socket.on 'paddle_pos', (x) =>
      @x = x

  updateFromMouse: ->
    @x = mousex || @x
    socket.emit('mouse_pos', @x)

  draw: ->
    ctx.fillStyle = @color
    ctx.fillRect(@x - @width/2, @y - @height/2 , @width, @height)


module.exports = Paddle