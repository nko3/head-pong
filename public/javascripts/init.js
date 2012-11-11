(function(){
  Puck = require('./puck')
  Paddle = require('./paddle')

  puck = new Puck(100, 100, 10)
  paddle1 = new Paddle(50, 50, 50, 20, 'blue')
  paddle2 = new Paddle(550, 550, 50, 20, 'red')

  socket.on('paddle_1_pos', function(x){
    paddle1.x = x
  })
  socket.on('paddle_2_pos', function(x){
    paddle2.x = x
  })
}())
