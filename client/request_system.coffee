random_floor = () ->
  Math.floor(Math.random() * 10)

floor_map = () ->
  _([1..10]).map () ->
    _([1..10]).map (n) -> 0

window.make_system = () ->
  window.System = system = {}

  system.request = (current_floor, destination) ->
    system.requests[current_floor][destination] += 1
    if current_floor > destination then direction = 'down'
    else direction = 'up'
    floor = $('.building .'+current_floor+' > .people')
    person = $('<span class="person '+direction+'"></span>')
    floor.append person
  system.requests = floor_map()

  system.arrival = (elevator) ->
    elevator.passengers[floor] = 0
    floor = elevator.floor
    door = $('.building .'+elevator.floor+' :nth-child('+elevator.id+')')
    door.removeClass('empty').addClass('arrived')
    if elevator.direction is 'up'
      if floor is 9
        elevator.direction = 'down'
      else
        _([floor..9]).each (destination) -> elevator.add_passenger destination
    if elevator.direction is 'down'
      if floor is 0
        return elevator.direction = 'up'
      else
        _([0..floor]).each (destination) -> elevator.add_passenger destination
    setTimeout system.departure, 1000, elevator
    return elevator

  system.departure = (elevator) ->
    door = $('.building .'+elevator.floor+' :nth-child('+elevator.id+')')
    door.removeClass('arrived').addClass('empty')
    if elevator.floor is elevator.destination
      return window.check_requests elevator
    system.arrival elevator.move()
