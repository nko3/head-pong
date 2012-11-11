(function(){
  socket = io.connect();
  socket.emit('connection')
}())