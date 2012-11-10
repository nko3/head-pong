class Puck
  constructor: (@x, @y, @dx, @dy, @radius) ->
    @color = 'black'

  move: ->
    @x += @dx
    @y += @dy

    if @x < @radius
      @x = @radius
      @dx *= -1
    if @x > canvas.width - @radius
      @x = canvas.width - @radius
      @dx *= -1
    if @y < @radius
      reset()
    if @y > canvas.height - @radius
      reset()

    if @collidedWith(paddle1)
      @dy = Math.abs(@dy)
      @y = paddle1.y + paddle1.height/2 + @radius

    if @collidedWith(paddle2)
      @dy = Math.abs(@dy) * -1
      @y = paddle2.y - paddle2.height/2 - @radius

  collidedWith: (paddle) ->
    if @x - @radius < paddle.x + paddle.width/2 && @x + @radius > paddle.x - paddle.width/2
      if @y - @radius < paddle.y + paddle.height/2 && @y > paddle.y
        return true
      if @y + @radius > paddle.y - paddle.height/2 && @y < paddle.y
        return true
    return false

  draw: (fillStyle = @color) ->
    ctx.fillStyle = fillStyle;
    ctx.beginPath()
    ctx.arc(@x, @y, @radius, 0, Math.PI * 2, false)
    ctx.fill()

module.exports = Puck