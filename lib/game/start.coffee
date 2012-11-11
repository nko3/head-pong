class Game
  constructor: (@socket) ->
    Puck = require('./puck')
    Paddle = require('./paddle')

    @puck = new Puck(10, @socket)
    @paddle1 = new Paddle(50, 50, 50, 20, @socket)
    @paddle2 = new Paddle(550, 550, 50, 20, @socket)
    @mainLoop()

  mainLoop: ->
    @puck.move(@paddle1, @paddle2)
    @socket.emit('puck_pos', @puck.x, @puck.y)
    setTimeout =>
      @mainLoop()
    , 1000/60

  updatePaddle: (number, x) ->
    console.log(number, x)
    if number == 1
      @paddle1.x = x
      @socket.emit('paddle_1_pos', x)
    else
      @paddle2.x = x
      @socket.emit('paddle_2_pos', x)


module.exports = Game