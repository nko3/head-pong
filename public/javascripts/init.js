(function(){
  Puck = require('./puck')
  Paddle = require('./paddle')

  puck = new Puck(100, 100, 10)
  paddle1 = new Paddle(50, 50, 150, 40, 'img/redp.png')
  paddle2 = new Paddle(550, 550, 150, 40, 'img/bluep.png')
  explosions = []

  socket.on('paddle_top_pos', function(x){
    paddle1.x = x
  })
  socket.on('paddle_bottom_pos', function(x){
    paddle2.x = x
  })
  socket.on('other_connect', function(){
    $('#message').html("The being that you are playing against passes the turing test")
  })
  socket.on('other_disconnect', function(){
    $('#message').html("Please enjoy battling your robot overlords while we search for another player")
  })
}())
