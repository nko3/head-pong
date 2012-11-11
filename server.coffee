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

Game = require('./lib/game/start')
io = require('socket.io').listen(server, app)


global.canvas_width = 800
global.canvas_height = 600

games = []
randomString = -> Math.random().toString(36).substring(7)

io.sockets.on 'connection', (socket) ->
  console.log('you have connected')

  if games.length == 0
    games.push(new Game(socket))
  else
    openGames = games.filter (game) -> game.open
    if openGames.length > 0
      openGames[0].join(socket)
    else
      games.push(new Game(socket))

  socket.on 'paddle_hit', ->
    console.log('ball hit by paddle')
