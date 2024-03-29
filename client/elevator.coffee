random_floor = () ->
  Math.floor(Math.random() * 10)

window.make_elevators = (num) ->
  window.Elevators = []
  window.Elevators = _([0..num]).map (elevator, index) ->
    elevator = {}
    elevator.passengers = _([1..10]).map -> return 0
    elevator.floor = random_floor()
    elevator.direction = null
    elevator.destination = null
    elevator.id = index
    elevator.add_passenger = (destination) ->
      floor = elevator.floor
      elevator.passengers[destination] += window.System.requests[floor][destination]
      window.System.requests[floor][destination] = 0
      if elevator.direction is 'up'
        if destination > elevator.destination then elevator.destination = destination
      if elevator.direction is 'down'
        if destination < elevator.destination then elevator.destination = destination
      if floor > destination then remove_people floor, 'down'
      else remove_people floor, 'up'
      return elevator
    elevator.move = () ->
      if elevator.direction is 'up' then elevator.floor++
      if elevator.direction is 'down' then elevator.floor--
      return elevator
    return elevator
remove_people = (floor, direction) ->
  people = $('.building .'+floor+' > .people .person.'+direction)
  people.remove()