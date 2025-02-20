class FastEnemy extends Enemy {
  
  FastEnemy(int gridSize, float startX, float startY, SoundFile deathSound) {
    super(gridSize, startX, startY,deathSound);
    this.hp = 2;
    this.speed = 1.5 * 1.50; // 25% più veloce del normale
  }

  @Override
  void display() {
    if (hp == 2) {
      fill(0, 255, 0);
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
