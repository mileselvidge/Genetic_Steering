class World {
  final float FOOD_DENSITY = 1; // Food per 1000pix^2
  final float POISON_DENSITY = 0.2; 
  
  ArrayList<Vehicle> population = new ArrayList<Vehicle>();
  ArrayList<PVector> food = new ArrayList<PVector>();
  ArrayList<PVector> poison = new ArrayList<PVector>();
  
  Leaderboard lb;
  
  World(int start) { 
    // start = starting population
    for(int i = 0; i < start; i++) {
    // Generate starting population (BLANK DNA)
      Vehicle v = new Vehicle(random(width), random(height), new DNA());
      population.add(v);
    }
    
    int totFood = (int) FOOD_DENSITY * ((width * height) / 1000);
    int totPoi = (int) POISON_DENSITY * ((width * height) / 1000);
    
    for(int i = 0; i < totFood; i++) {
      food.add(randomVector());
    }
    for(int i = 0; i < totPoi; i++) {
      poison.add(randomVector());
    }
    
    lb = new Leaderboard();
    updateLeaderboard();
  }
  
  void updateLeaderboard() {
    // Get oldest, healthiest and fittest vehicles
    int[] indicies = {-1, -1, -1};
    float[] winners = {-1, -1, -1};
    float[] totals = {0, 0, 0};
    int i = 0;
    for(Vehicle v : population) {
      if(v.age > winners[0]){
        winners[0] = v.age;
        indicies[0] = i;
      }
      
      if(v.health > winners[1]) {
        winners[1] = v.health;
        indicies[1] = i;
      }
      
      if(v.fitness() > winners[2]) {
        winners[2] = v.fitness();
        indicies[2] = i;
      }
      
      totals[0] += v.age;
      totals[1] += v.health;
      totals[2] += v.fitness();
      if(v.fitness() > maxfitness) {
        maxfitness = v.fitness();
      }
      i++;
    }
    
    // Update leaderboard statistics
    lb.oldest = population.get(indicies[0]);
    lb.healthiest = population.get(indicies[1]);
    lb.fittest = population.get(indicies[2]);
    lb.population = population.size();
    for(int j = 0; j < totals.length; j++){
      totals[j] = totals[j] / population.size(); // Mean totals
    }
    lb.means = totals; // TODO: Change to median for better measure of central tendancy
    
    // Append to history arraylist
    String[] index = {("" + (f/5)),(totals[2]+""),(maxfitness+""),(totals[0]+""),(totals[1]+""),(population.size()+"")};
    history.add(index);
  }
  
  void update() {
    // Generate new food/poison
    if(random(population.size()) < population.size() * FOOD_DENSITY){
      food.add(randomVector());
    }
  
    if(random(population.size()) < population.size() * POISON_DENSITY * 0.5) {
      poison.add(randomVector());
    }
    
    // Display food / poison
    fill(0, 255, 0);
    for(PVector f : food) { ellipse(f.x, f.y, 5, 5); }
    fill(150, 0, 150);
    for(PVector p : poison) { ellipse(p.x, p.y, 5, 5); }
    
    // Iterate through vehicle updates
      for(int i = population.size()-1; i >= 0; i--) {
        Vehicle v = population.get(i);
        v.boundaries();
    
        v.addBehavior(food, poison);
        //population = v.killFlee(population);
        v.update();
        v.display(settings[0]);
    
        Vehicle newVehicle = v.clone();
        if(newVehicle != null) {
          population.add(newVehicle);
        }
    
        if(!v.isAlive()) {
          population.remove(i);
          food.add(new PVector(v.pos.x, v.pos.y)); // random food about death location
        } else {
          population.set(i, v);
        }
    }
  }
  
  PVector randomVector(){ return new PVector(random(width), random(height)); } 
}