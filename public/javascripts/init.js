(function(){
  Puck = require('./puck')
  Paddle = require('./paddle')

  puck = new Puck(100, 100, 3, 3, 30)
  paddle1 = new Paddle(50, 50, 30, 10, 'blue')
  paddle2 = new Paddle(50, 550, 30, 10, 'red')
}())
