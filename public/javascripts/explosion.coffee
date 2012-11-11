class Explosion
  constructor: (@x, @y, @width = 63, @height = 56) ->
    @sprites = new Image();
    @sprites.src = 'img/explosion.png'
    @currentFrame = 0
    @totalFrames = 16
    @frameWidth = 63
    @frameHeight = 56

  updateFrame: ->
    @currentFrame += 1
    if @currentFrame >= @totalFrames
      @currentFrame = 0

  draw: ->
    ctx.drawImage(@sprites,
                  @currentFrame*@frameHeight, 0, @frameWidth, @frameHeight,
                  @x - @width/2, @y - @height/2, @width, @height)

module.exports = Explosion