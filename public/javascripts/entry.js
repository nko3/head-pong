window.onload = function(){
  canvas = document.getElementById("pong")
  ctx = canvas.getContext("2d")

  init = require('./init')
  init(ctx)
}