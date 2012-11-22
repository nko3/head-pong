class Paddle
  constructor: (@x, @y, @width, @height, src) ->
    @drawx = @x
    @sprites = new Image();
    @sprites.src = src
    @currentFrame = 0
    @frameWidth = 167
    @frameHeight = 60
    @totalFrames = 7

  slide: ->
    @drawx += (@x - @drawx)/10

  updateFrame: ->
    @currentFrame += 1
    @currentFrame = 0 if @currentFrame >= @totalFrames

  draw: ->
    @slide()
    ctx.drawImage(@sprites,
                  @currentFrame*@frameWidth, 0, @frameWidth, @frameHeight,
                  @drawx - @width/2, @y - @height/2, @width, @height)


module.exports = Paddle