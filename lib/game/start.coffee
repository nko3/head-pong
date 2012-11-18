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

  setPositionEvent: (playerNumber, socket) ->
    socket.on 'mouse_pos', (x) =>
        @updatePaddle(playerNumber, x)

  newSocket: (socket) ->
    if @p1socket
      @p2socket = socket
      @setPositionEvent(2, socket)
      console.log('new socket 2: ' + @p2socket)
    else
      @p1socket = socket
      @setPositionEvent(1, socket)
      console.log('new socket 1: ' + @p1socket)
    @tellAboutConnections()
    @setDisconnectEvent(socket)

  tellAboutConnections: ->
    if @p2socket && @p1socket
      @p2socket.emit('other_connect')
      @p1socket.emit('other_connect')

  setDisconnectEvent: (socket) ->
    socket.on 'disconnect', =>
      if socket == @p1socket then @p1socket = null else @p2socket = null

      if @p1socket or @p2socket
        @open = true
        console.log("You've shut down, leaving 1 player")
      else
        @open = false
        console.log("You've shut down, making the room empty")

      @p2socket.emit('other_disconnect') if @p2socket
      @p1socket.emit('other_disconnect') if @p1socket

module.exports = Game