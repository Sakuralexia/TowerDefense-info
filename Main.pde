import processing.sound.*;

Game game;
SoundFile deathSound;

void setup() {
  size(800, 600);
 
  deathSound = new SoundFile(this, "damage_sound.mp3");
  game = new Game(deathSound);
}

void draw() {
  background(220);
  game.update();
  game.display();
}

void mousePressed() {
  game.placeTower(mouseX, mouseY);
}
