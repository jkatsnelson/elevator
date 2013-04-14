random_floor = () ->
  Math.floor(Math.random() * 10)

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
      if check_floors elevator, num then found_request = true
  if elevator.direction then return window.System.arrival elevator
  else 
    setTimeout window.startElevators, 1000
    return false

check_floors = (elevator, num) ->
  floor = elevator.floor
  requests = window.System.requests
  found_request = false
  _.each requests[floor+num], (request) ->
    unless found_request
      if request
        elevator.direction = 'up'
        elevator.destination = floor+num
        found_request = true
  unless found_request
    _.each requests[floor-num], (request) ->
      unless found_request
        if request
          elevator.direction = 'down'
          elevator.destination = floor-num
          found_request = true
  found_request

Meteor.startup ->
  window.makeSystem()
  window.make_elevators 2 
  make_requests 20
  console.log window.System.requests
  window.startElevators()