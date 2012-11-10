window.onload = function(){
  var socket = io.connect();
  socket.on('news', function (data) {
    alert(data);
    socket.emit('my other event', { my: 'data' });
  });
  require('./jquery')
  require('./mouse')
  require('./animationFrame')
  require('./canvas')
  require('./init')
  start = require('./start')
  start()
}