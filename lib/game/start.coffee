class Game
  constructor: (socket) ->
    Puck = require('./puck')
    Paddle = require('./paddle')

    @puck = new Puck(10, socket)
    @paddle1 = new Paddle(50, 50, 150, 40, socket)
    @paddle2 = new Paddle(550, 550, 150, 40, socket)
    @open = true
    @newSocket(socket)
    @mainLoop()
    @x = 100
    @y = 100

  join: (socket) ->
    @newSocket(socket)
    @open = false

  mainLoop: ->
    @puck.move(@paddle1, @paddle2)
    if @p1socket
      @p1socket.emit('puck_pos', @puck.x, @puck.y)
    else
      @paddle1.ai(@puck)
      @updatePaddle(1, @paddle1.x)
    if @p2socket
      @p2socket.emit('puck_pos', @puck.x, @puck.y)
    else
      @paddle2.ai(@puck)
      @updatePaddle(2, @paddle2.x)

    setTimeout =>
      @mainLoop()
    , 1000/60

  updatePaddle: (number, x) ->
    if number == 1
      @paddle1.x = x
    else
      @paddle2.x = x

    console.log('updating paddle')

    @p1socket.emit("paddle_#{number}_pos", x) if @p1socket?
    @p2socket.emit("paddle_#{number}_pos", x) if @p2socket?

  newSocket: (socket) ->
    if @p1socket
      socket.on 'mouse_pos', (x) =>
        @updatePaddle(2, x)
        console.log "1.mouse_pow: #{x}"
      socket.on 'disconnect', (x) =>
        if @p1socket and @p1socket != null
          @p2socket = null
          @open = true
          console.log('p2 has shut down, leaving player 1')
        else
          @open = false
          console.log('p2 has shut down, leaving the game empty')
      @p2socket = socket
    else
      socket.on 'mouse_pos', (x) =>
        @updatePaddle(1, x)
        console.log "1.mouse_pow: #{x}"
      socket.on 'disconnect', (x) =>
        if @p2socket and @p2socket != null
          @p1socket = null
          @open = true
          console.log('p1 has shut down, leaving player 2')
        else
          @open = false
          console.log('p1 has shut down, leaving the game empty')
      @p1socket = socket


module.exports = Game