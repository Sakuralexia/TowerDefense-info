Game game;

void setup() {
  size(800, 600);
  game = new Game();
}

void draw() {
  background(220);
  game.update();
  game.display();
}

void mousePressed() {
  game.placeTower(mouseX, mouseY);
}
