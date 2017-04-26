## Genetic Steering (with Data Visuals)
This is my attempt to extend Dan Shiffman's (The Coding Rainbow) genetic algorithm for vehicles with steering behaviors.
I have used some of the key concepts shared in his tutorials, such as steering behaviors and the concept of food, poison and vehicles themselves as a foundation to my project.

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
2. Mean Fitness
3. Maximum Fitness 
4. Mean Age
5. Mean Health
6. Population Size

This made for some interesting graphics on Excel:
