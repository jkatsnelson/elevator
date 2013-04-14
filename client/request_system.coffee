random_floor = () ->
  Math.floor(Math.random() * 10)

floor_map = () ->
  _([1..10]).map () ->
    _([1..10]).map (n) -> 0

window.make_system = () ->
  window.System = system = {}

  system.request = (current_floor, destination) ->
    system.requests[current_floor][destination] += 1
  system.requests = floor_map()

  system.arrival = (elevator) ->
    elevator.passengers[floor] = 0
    floor = elevator.floor
    if elevator.direction is 'up'
      _([floor..9]).each (destination) -> elevator.add_passenger destination
    if elevator.direction is 'down'
      _([0..floor]).each (destination) -> elevator.add_passenger destination
    setTimeout system.departure, 1000, elevator
    return elevator

  system.departure = (elevator) ->
    floor = elevator.floor
    console.log 'departing from ' + floor
    if floor is 9 then elevator.direction = 'down'
    if floor is 0 then elevator.direction = 'up'
    if elevator.floor is elevator.destination
      elevator.destination = null
      elevator.direction = null
    if elevator.destination is null
      return window.check_requests elevator
    system.arrival elevator.move()
