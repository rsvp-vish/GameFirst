import sprites.utils.*;
import sprites.maths.*;
import sprites.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import java.util.ArrayList;

PImage rain;
Sprite bucket;
Sprite newDrop;
Sprite Pdrop;
Sprite Background;

int dropCounter = 0;
int BadDropCounter = 0;
int PdropCounter = 0;
int score = 0;
int gameLength = 10;
int life = 3;
boolean pdrop_actove = false;

ArrayList<Sprite> drops = new ArrayList<Sprite>();
ArrayList<Sprite> BadDrops = new ArrayList<Sprite>();
ArrayList<Sprite> Pdrops = new ArrayList<Sprite>();

public void setup() {
  size(500, 500);
  Background = new Sprite(this, "Background.png", 2);
  Background.setScale(1.4);

  for (int i = 0; i < 100; i++) { //i = i + 1;
    Sprite newDrop = new Sprite(this, "drop.png", 1);
    newDrop.setScale(.2);
    newDrop.setY(0);
    newDrop.setX(random(0, width)); //randon(0,500)
    newDrop.setVelY(5);
    drops.add(newDrop);
  }
  for (int i = 0; i < 100; i++) { //i = i + 1;
    Sprite newBadDrop = new Sprite(this, "BadDrop.png", 1);
    newBadDrop.setScale(.2);
    newBadDrop.setY(0);
    newBadDrop.setX(random(0, width)); //randon(0,500)
    newBadDrop.setVelY(7);
    BadDrops.add(newBadDrop);
  }
  for (int i = 0; i < 100; i++) { //i = i + 1;
    Sprite newPdrop = new Sprite(this, "Pdrop.png", 1);
    newPdrop.setScale(.2);
    newPdrop.setY(0);
    newPdrop.setX(random(0, width)); //randon(0,500)
    newPdrop.setVelY(15);
    Pdrops.add(newPdrop);
  }
  bucket = new Sprite(this, "bucket.png", 1);
  bucket.setScale(1);
  bucket.setXY(40, height-40);
}

public void draw() {
  rect(0, 0, width, height, 1);
  text("score: "+score, 10, 20);
  bucket.setX(mouseX);
  bucket.setY(mouseY);
  Background.draw();
  bucket.draw();



  Sprite drop = drops.get(dropCounter);
  drop.setY(drop.getY() + drop.getVelY());
  Sprite BadDrop = BadDrops.get(BadDropCounter);
  BadDrop.setY(BadDrop.getY() + BadDrop.getVelY());
  Sprite Pdrop = Pdrops.get(PdropCounter);
  Pdrop.setY(Pdrop.getY() + Pdrop.getVelY());
  if (dropCounter+1 >= drops.size()) {
    dropCounter = 0;
    score = 0;
    println("You Won");
    gameLength = gameLength + 10;
    for (int i = 0; i < gameLength; i++) {
      Sprite dropUpdate = drops.get(i);
      dropUpdate.setX(random(0, width));
      dropUpdate.setVisible(true);
    }
  }
  if (drop.getY() > height) {
    drop.setY(-20);
    dropCounter++;
  }
  if (BadDrop.getY() > height) {
    BadDrop.setY(-20);
    BadDropCounter++;
  }
  if (Pdrop.getY() > height) {
    Pdrop.setY(-20);
    PdropCounter ++;
  }



  drop.draw();
  BadDrop.draw();
  Pdrop.draw();



  if (drop.bb_collision(bucket)) {
    score++;
    drop.setVisible(false);
  }
  if (BadDrop.bb_collision(bucket)) {
    BadDrop.setVisible(false);
    score--;
  }
  if (Pdrop.bb_collision(bucket)) {
    Pdrop.setVisible(false);
    score++;
  }
}

