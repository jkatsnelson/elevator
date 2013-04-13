should = chai.should()


describe "Elevator Request System", ->
  beforeEach ->
    System = window.System
  afterEach ->
    window.makeSystem()
    window.makeElevators 3
  describe "request", ->
    it "should take requests", ->
      System.request.should.be.a 'function'
    it "should put a request in the request queue", ->
      System.request 0, 1
      System.requests[0][1].should.equal 1
    it "should call an elevator", ->
      beforeRequest = window.Elevators[0].direction
      System.request 1, 9
      afterRequest = window.Elevators[0].direction
      window.Elevators[0].direction.should.be.a 'string'
      afterRequest.should.not.equal beforeRequest
  describe "request queue", ->
    it "should be an array", ->
      System.requests.should.be.a 'array'
    it "should have 10 arrays that simulate floors", ->
      System.requests.length.should.equal 10
  describe "elevator arrival", ->
    it "should have an arrival function", ->
      System.arrival.should.be.a 'function'
    it "should pop requests into an elevator's passenger queue", ->
      System.request 0, 1
      beforeArrival = window.Elevators[0].passengers[1]
      window.Elevators[0].floor = 0
      System.arrival window.Elevators[0]
      afterArrival = window.Elevators[0].passengers[1]
      afterArrival.should.not.equal beforeArrival

describe "elevators", ->
  beforeEach ->
    Elevators = window.Elevators
  it "should have a passenger array", ->
    Elevators[0].passengers.should.be.a 'array'
    Elevators[0].passengers.length.should.equal 10
  describe "move", ->
    it "should be a function", ->
      Elevators[0].move.should.be.a 'function'
    it "should change an elevator's level", ->
      floor = Elevators[0].floor = 0
      Elevators[0].direction = 'up'
      Elevators[0].move()
      floor.should.not.equal Elevators[0].floor
    it "should not go past the 9th floor if it is going up", ->
      Elevators[0].floor = 8
      Elevators[0].direction = 'up'
      Elevators[0].move()
      Elevators[0].move()
      Elevators[0].floor.should.not.equal 10