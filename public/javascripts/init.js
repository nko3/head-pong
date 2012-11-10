(function(){
  Puck = require('./puck')
  Paddle = require('./paddle')

  puck = new Puck(100, 100, 5, 5, 10)
  paddle1 = new Paddle(50, 50, 50, 20, 'blue')
  paddle2 = new Paddle(550, 550, 50, 20, 'red')

  reset = function(){
    puck = new Puck(100, 100, 5, 5, 10)
  }
}())
