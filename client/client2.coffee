random_floor = () ->
  Math.floor(Math.random() * 10)

floor_map = () ->
  _([1..10]).map () ->
    _([1..10]).map (n) -> 0

callElevator = (current_floor, direction) ->
  elevators = window.Elevators
  _.each elevators, (elevator) ->
    unless calledElevator
      if elevator.floor is current_floor
        window.System.arrival elevator
      unless elevator.direction
        calledElevator = true
        elevator.direction = direction

window.makeSystem = () ->
  window.System = system = {}

  system.request = (current_floor, destination) ->
    system.requests[current_floor][destination] += 1
    if current_floor > destination
      callElevator current_floor, 'down'
    else
      callElevator current_floor, 'up'
  system.requests = floor_map()

  system.arrival = (elevator) ->
    floor = elevator.floor
    elevator.passengers[floor] = 0
    requests = system.requests[floor]
    if elevator.floor is elevator.destination
      elevator.destination = null
      elevator.direction = null
    switch elevator.direction
      # when null, analyze requests?
      when 'up'
        _([floor..9]).each (num) -> elevator.passengers[num] += requests[num]
      when 'down'
        _([0..floor]).each (num) -> elevator.passengers[num] += requests[num]
      when 'null' then checkRequests(elevator)
    elevator.move()

# take the elevator move and init functions out, and give them to the system.
window.makeElevators = (num) ->
  window.Elevators = _([1..num]).map (elevator) ->
    elevator = {}
    elevator.passengers = _([1..10]).map (val) -> val = 0
    elevator.floor = random_floor()
    elevator.direction = null
    elevator.destination = null
    elevator.move = () ->
      switch elevator.direction
        when null then return
        when 'up' then elevator.floor++
        when 'down' then elevator.floor--
      window.System.arrival elevator
    return elevator
Meteor.startup ->
  window.makeSystem()
  window.makeElevators 3