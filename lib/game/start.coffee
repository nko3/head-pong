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
    @communicateWithClient(1)
    @communicateWithClient(2)

    setTimeout =>
      @mainLoop()
    , 1000/60

  communicateWithClient: (number) ->
    socket = eval("this.p#{number}socket")
    paddle = eval("this.paddle#{number}")

    if socket
      socket.emit('puck_pos', @puck.x, @puck.y)
    else
      paddle.ai(@puck)
      @updatePaddle(number, paddle.x)

  updatePaddle: (number, x) ->
    paddle = eval("this.paddle#{number}")
    paddle.x = x

    @p1socket.emit("paddle_#{number}_pos", x) if @p1socket?
    @p2socket.emit("paddle_#{number}_pos", x) if @p2socket?

  newSocket: (socket) ->
    if @p1socket
      socket.on 'mouse_pos', (x) =>
        @updatePaddle(2, x)
      socket.on 'disconnect', (x) =>
        if @p1socket and @p1socket != null
          @p2socket = null
          @open = true
          console.log('p2 has shut down, leaving player 1')
          @p1socket.emit('other_disconnect')
        else
          @open = false
          console.log('p2 has shut down, leaving the game empty')
      @p2socket = socket
      if @p1socket
        @p2socket.emit('other_connect')
        @p1socket.emit('other_connect')
    else
      socket.on 'mouse_pos', (x) =>
        @updatePaddle(1, x)
      socket.on 'disconnect', (x) =>
        if @p2socket and @p2socket != null
          @p1socket = null
          @open = true
          @p2socket.emit('other_disconnect')
          console.log('p1 has shut down, leaving player 2')
        else
          @open = false
          console.log('p1 has shut down, leaving the game empty')
      @p1socket = socket
      if @p2socket
        @p2socket.emit('other_connect')
        @p1socket.emit('other_connect')

module.exports = Game