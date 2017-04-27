class DNA {
  float[] dna;
  float mutationrate;
  
  String name;
  int generation = 1;
  
  DNA(){
    // Generate new DNA
    mutationrate = random(0.01, 0.05); // Mutation Rate
    dna = new float[10];
    dna[0] = random(-4, 4); // Food Attraction
    dna[1] = random(-4, 4); // Poison Attraction
    dna[2] = random(0, 200); // Food Perception radius
    dna[3] = random(0, 200); // Poison Perception radius
    dna[4] = random(1, 10); // Maxmimum Speed
    dna[5] = random(0.05, 0.3); // Maximum Force
    dna[6] = random(2, 10); // Size
    dna[7] = random(0, 300); // Kill / Flee range (TODO)
    dna[8] = random(0, 6); // Desire to kill (TODO)
    dna[9] = random(-3, 0); // Desire to flee (TODO)
    
    name = randomName();
  }
  
  void mutate(){
    boolean mutated = false;
    for(int i = 0; i < dna.length; i++) {
      if(random(1) <= mutationrate) {
      mutated = true;
      dna[i] += random(-abs(dna[i]/2), abs(dna[i]/2));
      if(i == 2 || i == 3 || i == 4 || i == 5 || i == 6 || i == 7) {
        if(dna[i] < 0){
          dna[i] = abs(dna[i]);
         }
        }
      }
    }
    if(mutated) {
      generation++;
    }
  }
}