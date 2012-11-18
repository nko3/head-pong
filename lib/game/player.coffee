#Player knows:
#game API:  (tellPlayers, playerLeaves)
#paddle API: (creation, ai, x)
#client side API: (other_connect, puck_pos, paddle_..._pos, mouse_pos)
class Player
  constructor: (socket, @position, @game) ->
    Paddle = require('./paddle')

    if socket then @enliven(socket) else @live = false

    y = if @position == 'top' then 50 else 550
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

  movePaddle: (puck) ->
    unless @socket && @live
      @paddle.ai(puck)
    @game.tellPlayers("paddle_#{@position}_pos", @paddle.x)

  updatePaddle: (x) ->
    @paddle.x = x

  setPositionEvent: ->
    @socket.on 'mouse_pos', (x) =>
        @updatePaddle(x)

module.exports = Player