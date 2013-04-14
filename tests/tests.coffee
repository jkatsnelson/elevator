should = chai.should()

describe "elevators", ->
  beforeEach ->
    Elevators = window.Elevators
  afterEach ->
    window.makeSystem()
    window.make_elevators 1
  it "should have a passenger array", ->
    Elevators[0].passengers.should.be.a 'array'
    Elevators[0].passengers.length.should.equal 10
  describe "move", ->
    it "should be a function", ->
      Elevators[0].move.should.be.a 'function'
    it "should change an elevator's level", ->
      floor = Elevators[0].floor = 0
      Elevators[0].direction = 'up'
      Elevators[0].destination = 1
      floor.should.not.equal Elevators[0].move()

describe "Elevator Request System", ->
  beforeEach ->
    System = window.System
  afterEach ->
    window.makeSystem()
    window.make_elevators 1
  describe "request", ->
    it "should take requests", ->
      System.request.should.be.a 'function'
    it "should put a request in the request queue", ->
      System.request 0, 1
      System.requests[0][1].should.equal 1
  describe "request queue", ->
    it "should be an array", ->
      System.requests.should.be.a 'array'
    it "should have 10 arrays that simulate floors", ->
      System.requests.length.should.equal 10
  describe "elevator arrival", ->
    it "should have an arrival function", ->
      System.arrival.should.be.a 'function'
    it "should pop requests into an elevator's passenger queue", ->
      System.request 1, 6
      before = 0
      window.Elevators[0].floor = 1
      window.Elevators[0].destination = 3
      window.Elevators[0].direction = 'up'
      afterArrival = window.System.arrival window.Elevators[0]
      afterArrival = afterArrival.passengers[6]
      afterArrival.should.not.equal before
    it "should pick up a passenger at the current level", ->
      System.request 1, 6
      System.request 1, 7
      System.request 1, 8
      requests = [0, 0, 0, 0, 0, 0, 1, 1, 1, 0]
      window.Elevators[0].floor = 0
      window.Elevators[0].destination = 1
      window.Elevators[0].direction = 'up'
      window.System.arrival window.Elevators[0]
      requests.should.not.equal System.requests[1]

describe "check_requests", ->
  beforeEach ->
    window.makeSystem()
    window.make_elevators 1
  it "should give an elevator a direction", ->
    elevator = window.Elevators[0]
    elevator.floor = 1
    window.System.request 5, 9
    result = window.check_requests elevator
    result.direction.should.be.a 'string'
  it "should make elevators idle if there are no requests", ->
    elevator = window.Elevators[0]
    result = window.check_requests elevator
    result.should.be.false