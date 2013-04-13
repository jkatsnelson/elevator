# randomFloor = () ->
#   Math.floor(Math.random() * 10) + 1

# makeFloors = () ->
#   floors = [1..10]
#   floors.map (num, i) ->
#     floors[i] = []
#   Session.set 'floors', floors

# elevators = []

# Meteor.methods
#   makeElevator : () ->
#     elevator =
#       occupants : [],
#       level : randomFloor(),
#       enter : () ->
#         floors = Session.get 'floors'
#         if @direction is 'up'
#           _.each floors[@level], (passenger, i) ->
#             if passenger.destination > @level
#               @occupants.push floors[@level][i].pop()
#         if @direction is 'down'
#           _.each floors[@level], (passenger, i) ->
#             if passenger.destination < @level
#               @occupants.push floors[@level][i].pop()
#       arrive : () ->
#         _.each @occupants, (passenger, i) ->
#           if passenger.destination is @level
#             @occupants[i].pop()
#         if floors[@level].length
#           @enter @direction
#         elevator
#     return elevator
#   ,
#   makeElevators : (amount) ->
#     elevators = [1..amount]
#     _.map elevators, (elevator, index) ->
#       elevators[index] = Meteor.call 'makeElevator'
#   ,
#   makePassenger : () ->
#     passenger = {}
#     chooseFloor passenger
#   ,
#   chooseFloor : (passenger) ->
#     passenger.destination = destination = randomFloor()
#     floors = Session.get 'floors'
#     floors[destination].push passenger
#     _.each elevators, (elevator) ->
#       unless gotElevator
#         unless elevator.direction
#           if elevator.level > passenger.destination
#             elevator.direction = 'up'
#           if elevator.level < passenger.destination
#             elevator.direction = 'down'
#           gotElevator = true
#     return passenger
# Meteor.startup ->
#   Meteor.call 'makeElevators', 3