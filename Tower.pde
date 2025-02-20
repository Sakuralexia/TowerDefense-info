class Tower {
  float x, y;
  int fireRate = 55;
  int lastShot = 0;
  float range = 100; // Range della torre

  Tower(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void shoot(ArrayList<Enemy> enemies, ArrayList<Bullet> bullets) {
    if (frameCount - lastShot > fireRate) {
      Enemy closestEnemy = null;
      float closestDist = range; // Consideriamo solo i nemici entro il range
      for (Enemy e : enemies) {
        float d = dist(x, y, e.x, e.y);
        if (d < closestDist) {
          closestDist = d;
          closestEnemy = e;
        }
      }

      if (closestEnemy != null) {
        bullets.add(new Bullet(x, y, closestEnemy));
        lastShot = frameCount;
      }
    }
  }

  void display() {
    fill(0, 0, 255);
    ellipse(x, y, 20, 20);
    noFill();
    stroke(0, 0, 255, 100);
    ellipse(x, y, range * 2, range * 2); // Visualizza il range
    noStroke();
  }
}
