class SlowEnemy extends Enemy {
  
  SlowEnemy(int gridSize, float startX, float startY, SoundFile deathSound) {
    super(gridSize, startX, startY,deathSound);
    this.hp = 5;
    this.speed = 1.5 * 0.75; // 25% più lento del normale
  }

  @Override
  void display() {
    if(hp == 5 || hp ==4){
      fill(34, 140, 219);
    }else if (hp == 3) {
      fill(0, 255, 0);
    } else if (hp == 2) {
      fill(255, 165, 0);
    } else if (hp == 1) {
      fill(255, 0, 0);
    } else {
      fill(255);
    } // Colore blu per distinguerlo
    
    ellipse(x, y, 20, 20);
    fill(0);
    textAlign(CENTER);
    text(hp, x, y - 10);
  }
}
