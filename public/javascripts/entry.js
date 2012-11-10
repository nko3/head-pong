window.onload = function(){
  var canvas = document.getElementById("pong")
  var ctx = canvas.getContext("2d")

  puck = require('./public/javascripts/puck')
  init = require('./public/javascripts/init')
  init.startGame
}