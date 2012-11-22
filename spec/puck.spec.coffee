global.canvas_height = 800
global.canvas_width = 600
Puck = require('../lib/game/puck')
puck = new Puck(10)
fakePaddle = {x: 0, y: 0, height: 0, width: 0}
describe 'puck movement', ->

  it 'should start in the middle', ->
    expect(puck.x).toEqual(global.canvas_width/2)
    expect(puck.y).toEqual(global.canvas_height/2)

  it 'should move by dx and dy', ->
    puck.move(fakePaddle, fakePaddle)
    expect(puck.x).toEqual(global.canvas_width/2 + puck.dx)
    expect(puck.y).toEqual(global.canvas_height/2 + puck.dy)

  it "should bounce off left wall", ->
    puck.x = 1 + puck.radius
    puck.dx = -5
    puck.move(fakePaddle, fakePaddle)
    expect(puck.x).toEqual(puck.radius + 4)
    puck.move(fakePaddle, fakePaddle)
    expect(puck.x).toEqual(puck.radius + 9)

  it "should bounce off right wall", ->
    puck.x = global.canvas_width - puck.radius - 1
    puck.dx = 5
    puck.move(fakePaddle, fakePaddle)
    expect(puck.x).toEqual(global.canvas_width - puck.radius - 4)
    puck.move(fakePaddle, fakePaddle)
    expect(puck.x).toEqual(global.canvas_width - puck.radius - 9)