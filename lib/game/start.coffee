class Game
  constructor: (socket) ->
    Puck = require('./puck')
    Paddle = require('./paddle')

    @puck = new Puck(10, socket)
    @paddle1 = new Paddle(50, 50, 50, 20, socket)
    @paddle2 = new Paddle(550, 550, 50, 20, socket)
    @open = true
    @newSocket(socket)

  join: (socket) ->
    @newSocket(socket)
    @open = false
    @mainLoop()

  mainLoop: ->
    unless @open
      @puck.move(@paddle1, @paddle2)
      @p1socket.emit('puck_pos', @puck.x, @puck.y)
      @p2socket.emit('puck_pos', @puck.x, @puck.y)

      setTimeout =>
        @mainLoop()
      , 1000/60

  updatePaddle: (number, x) ->
    if number == 1
      @paddle1.x = x
    else
      @paddle2.x = x

    @p1socket.emit("paddle_#{number}_pos", x) if @p1socket?
    @p2socket.emit("paddle_#{number}_pos", x) if @p2socket?

  newSocket: (socket) ->
    if @p1socket
      socket.on 'mouse_pos', (x) =>
        @updatePaddle(2, x)
      socket.on 'disconnect', (x) =>
        if @p1socket
          @p2socket = null
          @open = true
          console.log('p2 has shut down, leaving player 1')
        else
          console.log('p2 has shut down, leaving the game empty')
      @p2socket = socket
    else
      socket.on 'mouse_pos', (x) =>
        @updatePaddle(1, x)
      socket.on 'disconnect', (x) =>
        if @p2socket
          @p1socket = null
          @open = true
          console.log('p1 has shut down, leaving player 2')
        else
          console.log('p1 has shut down, leaving the game empty')
      @p1socket = socket


module.exports = Game