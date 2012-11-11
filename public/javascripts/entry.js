window.onload = function(){
  require('./jquery')
  require('./socket')
  require('../camera/jquery.objectdetect')
  require('./mouse')
  require('./animationFrame')
  require('./canvas')
  require('./init')

  start = require('./start')
  start()
}
