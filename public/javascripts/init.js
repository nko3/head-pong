(function(){
  socket = io.connect();
  socket.emit('connection')

  socket.on('other_connect', function(){
    $('#message').html("The being that you are playing against passes the turing test")
  })
  socket.on('other_disconnect', function(){
    $('#message').html("Please enjoy battling your robot overlords while we search for another player")
  })

  canvas = document.getElementById("pong")
  ctx = canvas.getContext("2d")
  explosions = []

  Puck = require('./puck')
  Paddle = require('./paddle')

  puck = new Puck(100, 100, 10)
  socket.on('live', function(player){
    position = player
    if (player == 'top') {
      myPaddle = new Paddle(50, 50, 150, 40, 'img/redp.png')
      otherPaddle = new Paddle(550, 550, 150, 40, 'img/bluep.png')
      socket.on('paddle_bottom_pos', function(x){
        otherPaddle.x = x
      })
    } else {
      otherPaddle = new Paddle(50, 50, 150, 40, 'img/redp.png')
      myPaddle = new Paddle(550, 550, 150, 40, 'img/bluep.png')
      socket.on('paddle_top_pos', function(x){
        otherPaddle.x = x
      })
    }
    start = require('./start')
    start()
  })




}())
