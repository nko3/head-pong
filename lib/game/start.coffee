#Game knows:
#Player API (creation, live, enliven, communicateWithClient, socket)
#Puck API (creation, move, x, y)
#'top' and 'bottom' as keywords to be sent to the client <- probably not good
class Game
  constructor: (socket) ->
    Puck = require('./puck')
    Player = require('./player')

    @puck = new Puck(20)
    @p1 = new Player(socket, 'top', @)
    @p2 = new Player(null, 'bottom', @)
    @open = true
    @mainLoop()
    @communicate()

  join: (socket) ->
    if @p1.live then @p2.enliven(socket) else @p1.enliven(socket)
    @open = false

  mainLoop: ->
    @puck.move(@p1.paddle, @p2.paddle)

    setTimeout =>
      @mainLoop()
    , 1000/30

  communicate: ->
    @tellPlayers('puck_pos', @puck.x, @puck.y, @puck.dx, @puck.dy)
    @p1.movePaddle(@puck)
    @p2.movePaddle(@puck)

    setTimeout =>
      @communicate()
    , 100

  tellPlayers: (message, args...) ->
    @p2.socket.emit(message, args...) if @p2 && @p2.socket && @p2.live
    @p1.socket.emit(message, args...) if @p1 && @p1.socket && @p1.live

  playerLeaves: ->
    if @p1.live or @p2.live
      @open = true
      console.log("You've shut down, leaving 1 player")
    else
      @open = false
      console.log("You've shut down, making the room empty")
    @tellPlayers('other_disconnect')

module.exports = Game