window.onload = function(){
  require('./animationFrame')
  canvas = document.getElementById("pong")

  ctx = canvas.getContext("2d")
  init = require('./init')
  init(canvas, ctx)
}