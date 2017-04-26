// Genetic Steering Java with a lot of data visualisation :D
// 
// Basis and ideas from Dan Shiffman (The Coding Rainbow)
// Week 2: The Nature of Code 2 (Genetic Algorithms)
// File of 5000 names from Project Euler 22.
//
// TODO: Optimise, 
// TODO: Add in fighting and fleeing behaviors, 
// TODO: Record and calculate median values for age/health/fitness 
//
// By Miles Elvidge, 17, 25/04/17

import java.math.*;
import java.util.*;

World world;

ArrayList<String> names;
float maxfitness = 2;

boolean[] settings;
ArrayList<String[]> history = new ArrayList<String[]>();

long f = 1;

void setup() {
  fullScreen();
 
  // Initiate settings
  // 0 == DEBUG
  // 1 == STATS
  settings = new boolean[2];
  for(int i = 0; i < settings.length; i++) {
    settings[i] = false;
  }
  
  String[] header = {"Frame","Mean Fitness","Maximum Fitness","Mean Age","Mean Health","Population"};
  history.add(header);
  
  names = readFile("names.txt");
  world = new World(25);
}

void draw() {
  background(51);
  noStroke();
  
  world.update();
  if(f % 5 == 0) { world.updateLeaderboard(); }
  if(f % 1000 == 0) { saveData(); }
  if(settings[1]) { world.lb.displayLeaderboard(); }
  
  f++;
}

String randomName() { return names.get(int(random(names.size()))); }

void keyPressed() {
  if(keyCode == 68) { settings[0] = !settings[0]; } // Toggle debug (D)
  if(keyCode == 83) { settings[1] = !settings[1]; } // Toggle Stats (S)  
  if(keyCode == 65) { saveData(); } // (A)
}

void saveData() {
  // Save data collected to CSV file
  String[] lines = new String[history.size()];
  for(int i = 0; i < history.size(); i++) {
    String str = "";
    for(int j = 0; j < history.get(0).length; j++) {
      str += history.get(i)[j] + ",";
    }
    lines[i] = str;
  }
  saveStrings("data.csv",lines);
}
  
ArrayList<String> readFile(String filename) {
  String[] file = loadStrings(filename);
  String arrStr = file[0];
  arrStr = arrStr.replaceAll("\"", "");
  ArrayList<String> names = new ArrayList<String>();
  String[] arr = arrStr.split(",");
  
  for(String name : arr) {
    String n = name.toLowerCase();
    n = n.substring(0,1).toUpperCase() + n.substring(1);
    names.add(n);
  }
  
  return names;
}