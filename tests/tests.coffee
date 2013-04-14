should = chai.should()

describe "elevators", ->
  elevator = null
  beforeEach ->
    window.make_system()
    window.make_elevators 1
    elevator = window.Elevators[0]
  it "should have a passenger array", ->
    elevator.passengers.should.be.a 'array'
    elevator.passengers.length.should.equal 10
  describe "move", ->
    it "should be a function", ->
      elevator.move.should.be.a 'function'
    it "should change an elevator's level", ->
      floor = elevator.floor = 0
      elevator.direction = 'up'
      elevator.destination = 1
      floor.should.not.equal elevator.move()

describe "Elevator Request System", ->
  
  elevator = null
  
  beforeEach ->
    System = window.System
    elevator = window.Elevators[0]
  
  afterEach ->
    window.make_system()
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
      elevator.floor = 1
      elevator.destination = 3
      elevator.direction = 'up'
      afterArrival = window.System.arrival elevator
      afterArrival = afterArrival.passengers[6]
      afterArrival.should.not.equal before
    it "should pick up a passenger at the current level", ->
      System.request 1, 6
      System.request 1, 7
      System.request 1, 8
      requests = [0, 0, 0, 0, 0, 0, 1, 1, 1, 0]
      elevator.floor = 0
      elevator.destination = 1
      elevator.direction = 'up'
      System.arrival elevator
      requests.should.not.equal System.requests[1]
    it "should not let opposite direction passengers in the elevator", ->
      System.request 5, 8
      System.request 5, 9
      System.request 5, 4
      System.request 5, 1
      before_arrival = [0, 1, 0, 0, 1, 0, 0, 0, 1, 1]
      elevator.floor = 5
      elevator.direction = 'up'
      System.arrival elevator
      after_arrival = [0, 1, 0, 0, 1, 0, 0, 0, 0, 0]
      after_arrival[1].should.equal System.requests[5][1]
      after_arrival[4].should.equal System.requests[5][4]
      before_arrival[9].should.not.equal System.requests[5][9]
      before_arrival[8].should.not.equal System.requests[5][8]
  
  describe "elevator departure", ->
    it "should have a departure function", ->
      System.departure.should.be.a 'function'
    it "should check if elevator needs directions", ->
      System.request 9, 8
      elevator.floor = 1
      elevator.destination = 1
      System.departure elevator
      elevator.destination.should.equal 9


describe "check_requests", ->
  elevator = null
  
  beforeEach ->
    window.make_system()
    window.make_elevators 1
    elevator = window.Elevators[0]
  
  it "should give an elevator a direction", ->
    elevator.floor = 1
    window.System.request 5, 9
    result = window.check_requests elevator
    result.direction.should.be.a 'string'
  
  it "should make elevators idle if there are no requests", ->
    result = window.check_requests elevator
    result.should.be.false

describe "check_floor", ->
  elevator = null
  
  beforeEach ->
    window.make_system()
    window.make_elevators 1
    elevator = window.Elevators[0]
  
  it "should return true if there are requests", ->
    elevator.floor = 0
    window.System.request 2, 1
    test = window.check_floor elevator, 2
    test.should.be.true
  
  it "should change an elevator's direciton to down if there are requests below it", ->
    elevator.floor = 6
    window.System.request 4, 1
    test = window.check_floor elevator, 2
    test.should.be.true
    elevator.direction.should.equal 'down'
    elevator.destination.should.equal 4