Elevator
=
------

How to run:
-

This uses [Meteorite].

Run it with this command to see my tests: 

```METEOR_MOCHA_TEST_DIRS="tests/" mrt```

When the tests are running, the visualization looks reminiscent of a building in the twilight zone.

If you want to see the visualization work (to a degree):

Launch app with:

```mrt```

And enjoy!

----
Based on this interview question:
--------------------------

Challenge 2 - Elevator Action
In this challenge, you will simulate the elevators in a building.  The challenge ends when all people have been delivered to the floors they have requested.
Rules/Requirements

there should be 3 elevators
there should be 10 floors
each elevator should start at a random floor
each elevator should have a “direction” (up or down)
simulate the action of 20 people
each person should arrive at a random floor, and request to go to a random floor
when a person requests a floor, they can only request “up” or “down” if the elevator has not arrived
when an elevator arrives, a person may enter it if it is traveling in the direction they wish to go
upon entering, the person should enter the floor they wish to travel to
Extra Credit

Visually display the action of the elevators and/or people
Implement n elevators, n people
Implement a “max capacity” for elevators (where capacity is the maximum number of people the elevator can hold)

---
TODOs
--


* conform to the rules
    --
    * After coming to a solution I liked, I noticed that I didn't conform to this rule: 
    >"when a person requests a floor, they can only request “up” or         “down” if the elevator has not arrived"

   * If I went back to implement it, it would be rather trivial. In fact, if you're interested in interviewing me ONLY if I complete this requirement, this is what I would go back and do (gladly):

        * Change the current 10 x 10 map I am using to hold requests.
            * It would be a 10 x 2 map instead. 10 floors, with 'up' or 'down' requests on each.
            * Inside the 'up' and 'down' arrays I would include a 'person' object that holds their destination as a value.
        * Change my add_passenger function on the elevator to pop people from a floor based on their direction: 'up' or 'down', and then add their request to an internal map.

        This isn't significantly different from my current architecture, since the elevator doesn't check destination values until it reaches that passenger's floor.


* Switch to pseudo-classical instantiation (?)
    --
    * I find it more readable not to use it. I prefer a function that "makes an elevator" vs instantiating a "new Elevator" but I know the performance and memory gains of using the "new" constructor and using prototypes is worth it. I certainly won't argue against optimization.

* Find a way not to pollute the window
  --
    * In order to test, I attached functions to the window. It seems that was the convention that the meteorite mocha-web package uses

* Prevent elevators from chasing the same request
 --
    

* Fix the visualization
    --
    * Once in a while when I run the script, it seems that the visualization gets confused and a seemingly phantom elevator starts picking up passengers.
    * I could have had passengers exit as well as enter
    * I could have implemented a button to "add requests"

* Implement elevator capacity
    --
    * I think with how I built it, this wouldn't be that hard...

* Use list comprehensions instead of _.each
    --
    * Coffeescript would optimize my loops if I did that.

* Integration testing
    --
    * Testing the whole process instead of the individual functions could have been a nice final step.

[Meteorite]: https://github.com/oortcloud/meteorite