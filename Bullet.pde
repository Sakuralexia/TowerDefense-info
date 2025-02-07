class Bullet {
  float x, y;
  float speed = 5;
  Enemy target;
  boolean hit = false;

  Bullet(float x, float y, Enemy target) {
    this.x = x;
    this.y = y;
    this.target = target;
  }

  void move() {
    if (target != null) {
      float angle = atan2(target.y - y, target.x - x);
      x += cos(angle) * speed;
      y += sin(angle) * speed;

      if (dist(x, y, target.x, target.y) < 5) {
        target.takeDamage();
        hit = true;
      }
    }
  }

  void display() {
    fill(0, 255, 0);
    ellipse(x, y, 5, 5);
  }
}
