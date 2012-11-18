#Player knows:
#game API:  (tellPlayers, playerLeaves)
#paddle API: (creation, ai, x)
#puck API: (x, y)
#client side API: (other_connect, puck_pos, paddle_..._pos, mouse_pos)
class Player
  constructor: (socket, @top, @game) ->
    Paddle = require('./paddle')

    if socket
      @enliven(socket)
    else
      @live = false

    y = if @top == 'top' then 50 else 550
    @paddle = new Paddle(550, y, 150, 40)
    @

  enliven: (socket) ->
    @live = true
    @socket = socket
    @setPositionEvent()
    @game.tellPlayers('other_connect')

    socket.on 'disconnect', =>
      @live = false
      @game.playerLeaves()

  communicateWithClient: (puck) ->
    if @socket && @live
      @socket.emit('puck_pos', puck.x, puck.y)
    else
      @paddle.ai(puck)
      @updatePaddle(@paddle.x)

  updatePaddle: (x) ->
    @paddle.x = x
    @game.tellPlayers("paddle_#{@top}_pos", x)

  setPositionEvent: ->
    @socket.on 'mouse_pos', (x) =>
        @updatePaddle(x)

module.exports = Player