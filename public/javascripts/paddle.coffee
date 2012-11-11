class Paddle
  constructor: (@x, @y, @width, @height, src) ->
    @sprites = new Image();
    @sprites.src = src
    @currentFrame = 0
    @frameWidth = 167
    @frameHeight = 60
    @totalFrames = 7

  updateFrame: ->
    @currentFrame += 1
    @currentFrame = 0 if @currentFrame >= @totalFrames

  draw: ->
    ctx.drawImage(@sprites,
                  @currentFrame*@frameWidth, 0, @frameWidth, @frameHeight,
                  @x - @width/2, @y - @height/2, @width, @height)


module.exports = Paddle