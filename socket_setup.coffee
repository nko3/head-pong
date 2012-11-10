io_setup = (io) ->
  io.sockets.on 'connection', (socket) ->
    console.log('you have connected')
    socket.on 'movement', (x) ->
      socket.emit('news', 'hey')
      console.log(x)
      socket.emit('news', 'bye')

    socket.on 'paddle_hit', ->
      console.log('ball hit by paddle')

    socket.on 'mouse_pos', (x) ->
      console.log('received mouse position: ' + x)
      socket.emit('paddle_pos', x)