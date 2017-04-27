class Leaderboard {
  Vehicle oldest;
  Vehicle healthiest;
  Vehicle fittest;
  
  float[] medians = {0, 0, 0};
  float[] means = {0, 0, 0};
  int population;
  
  Leaderboard() {
    oldest = null;
    healthiest = null;
    fittest = null;
    population = 0;
  }
  
  void displayLeaderboard() {
    // Leaderboard Boxes
    fill(255, 0, 0, 120);
    rect(width-300,0,width,200);

    fill(0, 255, 0, 200);
    rect(width-300,200,width,200);
    
    fill(0, 0, 255, 200);
    rect(width-300,400,width,200);
    
    fill(175, 200);
    rect(width-300,600,width,200);
    
    // Titles
    fill(255);
    textSize(35);
    text("Oldest",width-290,30);
    text("Healthiest",width-290,230);
    text("Fittest",width-290,430);
    text("Stats",width-290,630);
    
    // Record holder stats 
    pushMatrix();
    textSize(20);   
    text("Name: "+oldest.genes.name,width-290,50);
    text("Generation: "+oldest.genes.generation,width-290,75);
    text("Age: "+oldest.age,width-290,100);
    text("Health: "+oldest.health,width-290,125);
    text("Fittness: "+oldest.fitness(),width-290,150);
    translate(0,200);
    text("Name: "+healthiest.genes.name,width-290,50);
    text("Generation: "+healthiest.genes.generation,width-290,75);
    text("Age: "+healthiest.age,width-290,100);
    text("Health: "+healthiest.health,width-290,125);
    text("Fittness: "+healthiest.fitness(),width-290,150);
    translate(0,200);
    text("Name: "+fittest.genes.name,width-290,50);
    text("Generation: "+fittest.genes.generation,width-290,75);
    text("Age: "+fittest.age,width-290,100);
    text("Health: "+fittest.health,width-290,125);
    text("Fittness: "+fittest.fitness(),width-290,150);    
    translate(0,200);
    text("Population: "+population,width-290,50);
    text("Median Age: "+medians[0],width-290,75);
    text("Median Health: "+medians[1],width-290,100);
    text("Median Fittness: "+medians[2],width-290,125);
    text("Mean Fittness: "+means[2],width-290,150);
    text("FPS: "+frameRate,width-290,175);  
    popMatrix();

    // Present record holders
    fill(255, 0, 0, 120);
    ellipse(oldest.pos.x, oldest.pos.y, 30, 30);
    stroke(255, 0, 0);
    line(oldest.pos.x, oldest.pos.y, width-290, 30);
    
    fill(0, 255, 0, 120);
    ellipse(healthiest.pos.x,healthiest.pos.y, 30, 30);
    stroke(0, 255, 0);
    line(healthiest.pos.x, healthiest.pos.y, width-290, 230);
    
    fill(0, 0, 255, 120);
    ellipse(fittest.pos.x,fittest.pos.y, 30, 30);
    stroke(0, 0, 255);
    line(fittest.pos.x, fittest.pos.y, width-290, 430);
  }
  
}