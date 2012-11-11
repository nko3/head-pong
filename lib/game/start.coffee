class Game
  constructor: (@p1socket) ->
    Puck = require('./puck')
    Paddle = require('./paddle')

    @puck = new Puck(10, @socket)
    @paddle1 = new Paddle(50, 50, 50, 20, @socket)
    @paddle2 = new Paddle(550, 550, 50, 20, @socket)
    @open = true
    @p1socket.on 'mouse_pos', (x) =>
      @updatePaddle(1, x)
    @p1socket.on 'disconnect', =>
      if @p2socket
        @p1socket = @p2socket
        @p2socket = null
        @open = true
        console.log('game is now open')
      else
        @open = false
        console.log('this should shut down')
        #figure out how to shut down this game

  join: (p2socket) ->
    @p2socket = p2socket
    @p2socket.on 'mouse_pos', (x) =>
      @updatePaddle(2, x)
    @p2socket.on 'disconnect', =>
      if @p1socket
        @p2socket = null
        @open = true
        console.log('this game is now open')
      else
        @open = false
        console.log('this should shut down')
        #figure out how to shut down this game
    @open = false
    @mainLoop()

  mainLoop: ->
    if @p1socket && @p2socket
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

module.exports = Game