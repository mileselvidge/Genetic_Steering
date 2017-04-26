class Vehicle {
  final float CLONING_RATE = 0.002;
  
  // Variables
  PVector acc = new PVector();
  PVector vel = PVector.random2D().setMag(random(-3,3));
  PVector pos;
  int age = 0;
  
  float health = 1;
  float radius;
  
  float maxspeed;
  float maxforce;
  
  DNA genes;
  
  Vehicle(float x, float y, DNA dna) {
    genes = dna;
    genes.generation++;
    genes.mutate();
    if(random(1) > 0.99) {
      genes = new DNA();
    }
    
    // Initilize other variables 
    radius = genes.dna[6];
    maxforce = genes.dna[5];
    maxspeed = genes.dna[4];
    pos = new PVector(x, y);
  }
  
  void update() {
    // Update motion
    vel.add(acc);
    vel.limit(maxspeed);
    pos.add(vel);
    acc.mult(0);
    
    // Update Health and age
    health -= 0.005;
    age++;
  }
  
  float fitness() {
    return health * age; // arbitrary fitness function 
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target,pos);
    desired.setMag(maxspeed);
    
    PVector steer = PVector.sub(desired,vel);
    steer.limit(maxforce);
    
    return steer;
  }
  
  PVector eat(ArrayList<PVector> list, float gain, float perception) {
    // Look for vector to seek (food / poison)
    float record = 10000000;
    PVector closest = new PVector(-1, -1);
    for(int i = list.size()-1; i >=0; i--) {
      float d = pos.dist(list.get(i));
      if(d < record) {
        if(d < radius) {
          list.remove(i);
          health += gain;
        } else if(d <= perception) {
          record = d;
          closest = list.get(i);
        }
      }
    }
    
    if(closest.x != -1 && closest.y != -1) {
      return seek(closest);
    }
     
    return new PVector(0, 0);
  }
  
  void addBehavior(ArrayList<PVector> target, ArrayList<PVector> avoid) {
    PVector steerT = eat(target, 0.15, genes.dna[2]);
    PVector steerE = eat(avoid, -0.5, genes.dna[3]);
    PVector mouse = PVector.sub(new PVector(mouseX, mouseY), pos);
    
    steerT.mult(genes.dna[0]);
    steerE.mult(genes.dna[1]);
    mouse.mult(genes.dna[9]);
    
    applyForce(steerT);
    applyForce(steerE);
    //if(PVector.dist(pos,new PVector(mouseX, mouseY)) < genes.dna[8]) { applyForce(mouse); } // Scare
  }
  
  Vehicle clone() {
    if(random(1) < CLONING_RATE * map(fitness(),0,maxfitness,0,2)) {
      Vehicle v = new Vehicle(pos.x + random(-20, 20), pos.y + random(-20, 20), genes); 
      return v; 
    } else {
      return null;
    }
  }
  
  boolean isAlive() {
    return health > 0;
  }
  
  void boundaries() {
    // Ensure the vehicles remain within the desired screen region
    float d = 5;
    PVector desired = new PVector(-1, -1);
    
    if(pos.x < d) {
      desired = new PVector(maxspeed, vel.y);
    } else if(pos.x > width - d) {
      desired = new PVector(-maxspeed, vel.y);
    }
    
    if(pos.y < d) {
      desired = new PVector(vel.x, maxspeed);
    } else if(pos.y > height - d) {
      desired = new PVector(vel.x, -maxspeed);
    }
    
    if(desired.x != -1 && desired.y != -1) {
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired,vel);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }
  
  // ADD DEBUG OPTION
  void display(boolean debugging) {
    float theta = vel.heading() + PI/2;
    color gr = color(0, 255, 0);
    color pr = color(150, 0, 150);
    color col = lerpColor(pr,gr,health);
    
    // Display Vehicle
    pushMatrix();
    translate(pos.x,pos.y);
    
    if(debugging) {
      // Debug information
      noFill();
      stroke(pr);
      ellipse(0, 0, genes.dna[3], genes.dna[3]); // Vision Circles
      stroke(gr);
      ellipse(0, 0, genes.dna[2], genes.dna[2]);
    
      stroke(80);
      fill(80);
      alpha(100);
      rect(10, -10, 90, 55);
      fill(255);
      textSize(12);
      text("Name: "+genes.name+genes.generation,15,0);
      text("Age: "+age,15,20);
      text("Health: "+String.format("%.3g%n", health),15,40);
    
      pushMatrix();
      rotate(theta);
      stroke(gr);
      line(0, 0, 0, -map(genes.dna[0], -5, 5, -100, 100)); // Attraction lines
      stroke(pr);
      line(0, 0, 0, -map(genes.dna[1], -5, 5, -100, 100));
      popMatrix();
    }
    
    // Vehicle body
    float R = radius;
    fill(col);
    stroke(200); 
    strokeWeight(1);
    rotate(theta);
    beginShape();
    vertex(0, -R*2);
    vertex(-R, R*2);
    vertex(R, R*2);
    endShape(CLOSE);
    popMatrix();
  }
  
  
  // TODO: Add competition, fight, flight etc (radius determines who can eat who)
  //ArrayList<Vehicle> killFlee(ArrayList<Vehicle> others) {
  //  float killrate = genes.dna[9];
  //  float fleerate = genes.dna[10];
  //  float range = genes.dna[8];
    
  //  float largest = -1;
  //  float smallest = 1000;
  //  int largestI = -1;
  //  int smallestI = -1;
  //  for(int i = others.size() -1; i >= 0; i--) {
  //    float d = PVector.dist(pos,others.get(i).pos);
  //    if(d <= range) {
  //        if(d < radius && radius < others.get(i).radius && isAlive()){
  //          // Kill current
  //          others.get(i).health += health;
  //          health = 0;
  //        } else if(others.get(i).radius > largest && others.get(i).radius > radius){
  //          largest = others.get(i).radius;
  //          largestI = i;
  //        } else if(others.get(i).radius < smallest && others.get(i).radius < radius) {
  //          smallest = others.get(i).radius;
  //          smallestI = i;
  //        }
  //    }
  //  }
    
  //  // Seek relevent enemies
  //  if(smallestI != -1) {
  //    PVector steer = others.get(smallestI).pos;
  //    steer.mult(killrate);
  //    applyForce(steer);
  //  } 
  //  if(largestI != -1) {
  //    PVector steer = others.get(largestI).pos;
  //    steer.mult(fleerate);
  //    applyForce(steer);
  //  }
    
  //  return others;
  //}
}