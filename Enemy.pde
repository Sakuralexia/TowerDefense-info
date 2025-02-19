import processing.sound.*;

class Enemy {
  float x, y, speed;
  int hp;
  int step = 0;
  boolean isDead;
  int gridSize;
  int[][] path;
  SoundFile deathSound;

  Enemy(int gridSize, float startX, float startY, SoundFile deathSound) {
    this.gridSize = gridSize;
    this.x = startX;
    this.y = startY;
    this.speed = 1.5;
    this.hp = 3;
    this.isDead = false;
    this.path = new int[][] {
      {gridSize / 2, gridSize / 2},
      {200 + gridSize / 2, 100 + gridSize / 2},
      {200 + gridSize / 2, 200 + gridSize / 2},
      {400 + gridSize / 2, 200 + gridSize / 2},
      {400 + gridSize / 2, 300 + gridSize / 2},
      {600 + gridSize / 2, 300 + gridSize / 2},
      {600 + gridSize / 2, 400 + gridSize / 2},
      {width - gridSize / 2, 400 + gridSize / 2}
    };
    this.deathSound = deathSound;
  }

  void move() {
    if (step < path.length - 1) {
      float targetX = path[step + 1][0];
      float targetY = path[step + 1][1];
      
      if (dist(x, y, targetX, targetY) < 5) {
        step++;
      }

      float angle = atan2(targetY - y, targetX - x);
      x += cos(angle) * speed;
      y += sin(angle) * speed;
    }
  }

  void takeDamage() {
    hp--;
    if (hp <= 0 && !isDead) {
      isDead = true;
      deathSound.play();
    }
  }

  void display() {
    if (hp == 3) {
      fill(0, 255, 0);
    } else if (hp == 2) {
      fill(255, 165, 0);
    } else if (hp == 1) {
      fill(255, 0, 0);
    } else {
      fill(255);
    }

    ellipse(x, y, 20, 20);
    fill(0);
    textAlign(CENTER);
    text(hp, x, y - 10);
  }
}
