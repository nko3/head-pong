class Puck
  constructor: (@radius, @socket) ->
    @x = 1
    @y = 1
    @reset()

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
      @reset()
    if @y > global.canvas_height - @radius
      @reset()

    if @collidedWith(paddle1)
      @dy = Math.abs(@dy)
      @y = paddle1.y + paddle1.height/2 + @radius

    if @collidedWith(paddle2)
      @dy = Math.abs(@dy) * -1
      @y = paddle2.y - paddle2.height/2 - @radius

  collidedWith: (paddle) ->
    if @x - @radius < paddle.x + paddle.width/2 && @x + @radius > paddle.x - paddle.width/2
      if (@y - @radius < paddle.y + paddle.height/2 && @y > paddle.y) || (@y + @radius > paddle.y - paddle.height/2 && @y < paddle.y)
        @socket.emit('paddle_hit')
        return true
    return false

  reset: ->
    console.log('hello from the reset')
    @x = global.canvas_width/2
    @y = global.canvas_height/2
    @dx = Math.random()*10 - 5
    @dy = Math.random()*10 - 5

module.exports = Puck