# should = chai.should()

# describe "Elevators", ->
#   elevators = null
#   beforeEach ->
#     elevators = Meteor.call 'makeElevators', 3
#   it "produces an array of elevators", ->
#     elevators.should.be.a 'array'

# describe "Elevator", ->
#   elevator = null
#   beforeEach ->
#     elevators = Session.get 'elevators'
#     elevator = elevators.pop()
#   it "is an object", ->
#     elevator.should.be.a 'object'
#   it "has a level", ->
#     elevator.should.have.ownProperty 'level'
#   it "has an array of occupants", ->
#     elevator.should.have.ownProperty 'occupants'

# describe "passenger", ->
#   passenger = {}
#   beforeEach ->
#     passenger = makePassenger()
#   it "is an object", ->
#     passenger.should.be.a 'object'
#   it "has a destination", ->
#     passenger.should.have.ownProperty 'destination'
#   it "can change an elevator's direction", ->
#     true

# describe "Floor", ->
#   floors = {}
#   beforeEach ->
#     floors = Session.get 'floors'
#   it "is an array", ->
#     floors.should.be.a 'array'
#   it "has an array for each floor", ->
#     floors.length.should.equal 10
#     _(Floors).each (val, index) ->
#       val.should.be.a 'array'

# # describe "Leaderboard", ->
# #   describe "givePoints", ->
# #     it "gives 5 points to the user", ->
# #       #create a player
# #       playerId = Players.insert {name: "TestUser1", score: 5}
# #       Session.set "selected_player", playerId
# #       givePoints()
# #       player = Players.findOne(playerId)
# #       chai.assert.equal 10, player.score
# #       Players.remove {name: "TestUser1"}