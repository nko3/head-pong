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
      @dy *= -1
      @y = @radius
    if @y > canvas.height - @radius
      @dy *= -1
      @y = canvas.height - @radius

  collide: (paddle) ->
    if @x - @radius < paddle.x + paddle.width/2 && @x + @radius > paddle.x - paddle.width/2
      if @y - @radius < paddle.y + paddle.height/2 && @y > paddle.height/2
        @dy *= -1
        @y = paddle.y + @radius + paddle.height/2
      if @y + @radius > paddle.y + paddle.height/2 && @y < paddle.height/2
        @dy *= -1
        @y = paddle.y - @radius - paddle.height/2

  draw: (fillStyle = @color) ->
    ctx.fillStyle = fillStyle;
    ctx.beginPath()
    ctx.arc(@x, @y, @radius, 0, Math.PI * 2, false)
    ctx.fill()

module.exports = Puck