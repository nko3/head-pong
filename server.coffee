express = require("express")
app = express()
http = require('http')

app.configure ->
  app.set('port', process.env.PORT || 3000);
  app.use express.bodyParser()
  app.use app.router
  app.use express.static "#{__dirname}/public"

  app.set "views", "#{__dirname}/views"
  app.set "view engine", "jade"

app.get "/", (req, res) ->
    res.render "index"


app.get "/camera", (req, res) ->
    res.render "camera"

app.get "/game", (req, res) ->
    res.render "pong"

server = http.createServer(app).listen app.get('port'), ->
  console.log("Express server listening on port " + app.get('port'))

io = require('socket.io').listen(server, app)

io.sockets.on 'connection', (socket) ->
  console.log('you have connected')

  socket.on 'paddle_hit', ->
    console.log('ball hit by paddle')

  socket.on 'mouse_pos', (x) ->
    socket.emit('paddle_1_pos', x)
    setTimeout ->
      socket.emit('paddle_2_pos', x)
    , 1000

