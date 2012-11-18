class Puck
  move: (paddle1, paddle2) ->
    @x += @dx
    @y += @dy

    if @x < @radius
      @x = @radius
      @dx *= -1
    if @x > global.canvas_width - @radius
      @x = global.canvas_width - @radius
      @dx *= -1
    if @y < @radius
      @_reset()
    if @y > global.canvas_height - @radius
      @_reset()

    if @_collidedWith(paddle1)
      @dx += (Math.random()*10 - 5)
      @dy = Math.abs(@dy)
      @dy += 0.2
      @y = paddle1.y + paddle1.height + @radius
    else if @_collidedWith(paddle2)
      @dx += (Math.random()*10 - 5)
      @dy = Math.abs(@dy) * -1
      @dy -= 0.2
      @y = paddle2.y - paddle2.height/2 - @radius

  _collidedWith: (paddle) ->
    if @x - @radius < paddle.x + paddle.width/2 && @x + @radius > paddle.x - paddle.width/2
      if (@y - @radius < paddle.y + paddle.height/2 && @y > paddle.y) || (@y + @radius > paddle.y - paddle.height/2 && @y < paddle.y)
        return true
    return false

module.exports = Puck