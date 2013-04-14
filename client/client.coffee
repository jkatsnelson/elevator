random_floor = () ->
  Math.floor(Math.random() * 10)

floor_map = () ->
  _([1..10]).map () ->
    _([1..10]).map (n) -> 0

make_requests = (num) ->
  if num
    current_floor = random_floor()
    destination = random_floor()
    if current_floor is destination then make_requests num
    window.System.request current_floor, destination
    num--
    return make_requests num

window.check_requests = (elevator) ->
  floor = elevator.floor
  requests = window.System.requests
  found_request = false
  _([0..9]).each (num) ->
    unless found_request
      _.each requests[floor+num], (request) ->
        unless found_request
          if request
            elevator.direction = 'up'
            elevator.destination = floor+num
            found_request = true
      _.each requests[floor-num], (request) ->
        unless found_request
          if request
            elevator.direction = 'down'
            elevator.destination = floor-num
            found_request = true
    if elevator.direction then return elevator
    else 
      setTimeout window.startElevators, 1000
      return false

window.makeSystem = () ->
  window.System = system = {}

  system.request = (current_floor, destination) ->
    system.requests[current_floor][destination] += 1
  system.requests = floor_map()

  system.arrival = (elevator) ->
    unless elevator return
    floor = elevator.floor
    elevator.passengers[floor] = 0
    requests = system.requests[floor]
    if floor is 9 then elevator.direction = 'down'
    if floor is 1 then elevator.direction = 'up'
    switch elevator.direction
      when 'up'
        _([floor..9]).each (num) -> 
          if requests[num]
            elevator.passengers[num] += requests[num]
            requests[num] = 0
            if num > elevator.destination then elevator.destination = num
      when 'down'
        _([0..floor]).each (num) ->
          if requests[num]
            elevator.passengers[num] += requests[num]
            requests[num] = 0
            if num < elevator.destination then elevator.destination = num
      system.departure elevator

  system.departure = (elevator) ->
    if elevator.floor is elevator.destination
      elevator.destination = null
      elevator.direction = null
    if elevator.destination is null
      return check_requests elevator
    system.arrival elevator.move()

window.makeElevators = (num) ->
  window.Elevators = []
  window.Elevators = _([1..num]).map (elevator) ->
    elevator = {}
    elevator.passengers = _([1..10]).map -> return 0
    elevator.floor = random_floor()
    elevator.direction = null
    elevator.destination = null
    elevator.move = () ->
      switch elevator.direction
        when 'up' then elevator.floor++
        when 'down' then elevator.floor--
      return elevator
    return elevator

window.startElevators = () ->
  _.each window.Elevators, (elevator) ->
    if elevator.direction is null
      window.System.arrival elevator

Meteor.startup ->
  window.makeSystem()
  window.makeElevators 1
  window.System.request 1, 8
  window.startElevators()