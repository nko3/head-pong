(function(){
  socket = io.connect();
  socket.emit('connection')
  socket.on('news', function (data) {
    console.log(data);
    socket.emit('movement', 'data');
  });
}())