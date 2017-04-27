## Genetic Steering (with Data Visuals)
This is my attempt to extend Dan Shiffman's (The Coding Rainbow) genetic algorithm for vehicles with steering behaviors.
I have used some of the key concepts shared in his tutorials, such as steering behaviors and the concept of food, poison and vehicles themselves as a foundation to my project. I am very excited for all that is to come!

***

# What have I added?
* I started by creating a program similar to Dan Shiffman's example in Week 2 (Genetic Algorithms) of the Nature of Code 2 in Java in the Processing Enviroment. 
* An Object-Oriented implementation: 
  * A World class to handle ArrayLists of Vectors and Vehicles (as well as statistic calculation added later).
  * A DNA class to store the float array corresponding to the attributes of a vehicle.
  * A Vehicle class to handle steering physics and behaviors.
  * The Main class is used for handling the world, inputs, reading from files and writing to CSV files (statistics).
  * A Leaderboard class is used to hold key statistics (means, oldest, healthiest and fittest vehicles etc) and a fancy leaderboard visualisation.
* I added more features to the DNA:
  * It is now held within it's own Class.
  * Mutation rates vary.
  * 1% of the time when a vehicle reproduces, the DNA will be entirely revised.
  * Mutations can drastically change the behavior of a vehicle.
  * Vehicles now have names/species (randomly selected from a list of 5000 names) and generations. This adds for some cool analysis of the population.
  * Size, Maximum Velocity and Maximum Force are now factors of the genetic code.
  * Data which must be positive is made so.
 * I added serval constants which control food/poison density and cloning rate.
 * Vehicles now contain information regarding age (frames alive) and fitness (a function calculated as the product of age and health).
 * Debug mode not only shows Vehicle perceptions and perferences, it also displays the species/name, generaiton number, age and health.
 * The Leaderboard (see below).
 * Statistics calculated outputted to a CSV file (see below).
 * The fittest vehicles have an increased probability of reproducing.
 
*** 

# How to use:

**Press D:** toggle debugging information. 

**Press S:** toggle leaderboard information. 

**Press A:** force a save to CSV.


***

# Data Visualisation (and The Leaderboard)
Perhaps what interested me the most about writing this genetic algorithm was how certain variables, such as the average age and health of a vehicle changed over time. Not only did I want to see this in realtime, I wanted some way of producing an output from the program which I could analyse.

The Leaderboard is my first attempt at this:
* It provides a graphical interface for identifying the oldest, healthiest, fittest vehicles (and their stats).
* It calculates and displays statistics such as:
  * Population size,
  * Mean Age,
  * Mean Health,
  * Mean Fitness,
  * FPS
  
This allowed for realtime visualisation on how the population was performing.
_Example: I ran my program for 2 hours and reached mean fitnesses of around 5 million, and a fan which became a speaker._

Additionally, I wanted a way to view the data afterwards, and see how it progressed over time, say, in an Excel graph or something. This is what I ended up doing, I would store key statistical values every *5 frames* in an ArrayList of String array containing such values as mean age and fitness.

**The output is stored every 1000 frames to a file named _data.csv_**
The file contains: 
1. Frame Number (Multiple 5, eg: 1 = 5, etc.)
2. Median Fitness
3. Mean Fitness
4. Maximum Fitness 
5. Median Age
6. Median Health
7. Population Size

This made for some interesting graphics on Excel:
![alt text](http://i.imgur.com/uKdcvBX.png "Data and graphs")

_To the right you can see the raw CSV data returned by the program (for this example, 1 hour of running, the CSV file has around 47000 lines_
_To the left are two graphs
* The top graph displays how maximum and mean fitness change over time..
* The bottom graph shows how mean health (yellow) and population size (blue) change over time..._

**The Excel workbook containing this example is included in this repo :D**

***

## TODO:
Of course, I am not done with this project. As a 17 year old and someone who is fairly new and facinated to programming, this project, the learning, coding and even posting to github has been exciting. I can't wait to continue.

I have a few future plans:
* ~~The mean value is skewed by extreme values, such as the maximum (see fitness-frames graph above), a **median** average would make for a much better approximation of the central tendancy for the population.~~
* Optimise. The calculation of the median would involve sorting various different lists, this could have a serious effect on performance.
* Add in fighting and fleeing behaviors to the vehicles to add another factor (perhaps to control overpopulation etc.)
  * Vehicles bigger than other vehicles are attracted to them and can eat them,
  * Vehicles smaller than others flee from the larger ones,
  * A vehicle dies when eaten and the _eater_ gains the health of the killed victim,
  * As a result, to balance things, I would have to make the speed of a vehicle greater for smaller ones...
  * ... and add a part of the DNA which relates to a vehicle's fight or flight response.
  * ***I attempted implementing once this however was unsuccessful*** 
* Make a spin-off game version where a user controls a vehicle in the race for food, obviously the game gets harder as time progresses as the genetics of the population improve.

***

## Images

The Simulation in action: 
![alt text](http://i.imgur.com/B6Vi2o8.png "Simulation with stats only.")
![alt text](http://i.imgur.com/ScqUZwW.png "Simulation with stats and debugging information.")

*** 

# Update: 27/04/17
* Changed measures of central tendancy of statistics from means to medians. On paper this sounds great, but the fitness function might need revising as the cloning of new vehicles (with zero age) skews their fitness for the first few frames and makes the median very fluctuant and hard to analyse.
* Wrote a distSq() function to elliminate the use of PVector.dist() which uses the sqrt() function (Slow...).

# Update: 27/04/17 Pt2
* Updated Fitness Function, now takes into account average time between eating the food and parents lifespan to reduce dependance on age. 

***

## References
Dan Shiffman:
* http://shiffman.net
* https://github.com/shiffman
* https://www.youtube.com/user/shiffman

Nature of Code 2: 
* https://github.com/shiffman/NOC-S17-2-Intelligence-Learning

Project Euler 22 (where I sources the 5000 random names):
* https://projecteuler.net/problem=22

Processing: 
* https://processing.org


 
