class Game {
  ArrayList<Enemy> enemies;
  ArrayList<Tower> towers;
  ArrayList<Bullet> bullets;
  int points;
  int lives;
  int gridSize = 40;
  int wave = 1;
  int enemiesLeftToSpawn;
  int spawnTimer = 0;
  boolean waveActive = false;

  Game() {
    enemies = new ArrayList<Enemy>();
    towers = new ArrayList<Tower>();
    bullets = new ArrayList<Bullet>();
    points = 100;
    lives = 10;
    startNewWave();
  }

  void startNewWave() {
    waveActive = true;
    enemiesLeftToSpawn = min(3 + wave, 15);
  }

  void update() {
    if (waveActive) {
      if (enemiesLeftToSpawn > 0 && spawnTimer % 60 == 0) {
        float spawnX = gridSize / 2;
        float spawnY = gridSize / 2;
        enemies.add(new Enemy(gridSize, spawnX, spawnY));
        enemiesLeftToSpawn--;
      }
      spawnTimer++;

      if (enemies.isEmpty() && enemiesLeftToSpawn == 0) {
        wave++;
        startNewWave();
      }
    }

    for (Tower t : towers) {
      t.shoot(enemies, bullets);
    }

    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy e = enemies.get(i);
      e.move();
      if (e.hp <= 0) {
        enemies.remove(i);
        points += 10;
      }

      if (e.step == e.path.length - 1) {
        enemies.remove(i);
        lives--;
        if (lives <= 0) {
          gameOver();
        }
      }
    }

    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.move();
      if (b.hit) {
        bullets.remove(i);
      }
    }
  }

  void display() {
    background(255);

    drawGrid();
    drawPath();

    for (Tower t : towers) {
      t.display();
    }

    for (Enemy e : enemies) {
      e.display();
    }

    for (Bullet b : bullets) {
      b.display();
    }

    fill(0);
    textSize(16);
    textAlign(RIGHT, TOP);
    text("Punti: " + points, width - 10, 10);
    text("Ondata: " + wave, width - 10, 30);
    text("Vite: " + lives, width - 10, 50);
    text("Punti per torre: " + 50, width - 10, 70);
  }

  void drawGrid() {
    stroke(0);
    noFill();
    for (int i = 0; i < width; i += gridSize) {
        for (int j = 0; j < height; j += gridSize) {
            rect(i, j, gridSize, gridSize);
        }
    }
  }

  void drawPath() {
    for (Enemy e : enemies) {
        stroke(150, 100, 50);
        strokeWeight(10);
        noFill();

        beginShape();
        for (int i = 0; i < e.path.length; i++) {
            vertex(e.path[i][0], e.path[i][1]);
        }
        endShape();
        
        strokeWeight(1);
    }
  }

  void gameOver() {
    noLoop();
    textSize(32);
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width / 2, height / 2);
  }

  void placeTower(int x, int y) {
    int gridX = floor(x / gridSize) * gridSize;
    int gridY = floor(y / gridSize) * gridSize;

    if (gridX >= 0 && gridX < width && gridY >= 0 && gridY < height && points >= 50 && isValidPosition(gridX, gridY) && !towerAtPosition(gridX, gridY)) {
      towers.add(new Tower(gridX + gridSize / 2, gridY + gridSize / 2));  
      points -= 50;
    }
  }

  boolean isValidPosition(int x, int y) {
    for (Enemy e : enemies) {
      for (int[] point : e.path) {
        int pathX = point[0];
        int pathY = point[1];
        if (dist(x, y, pathX, pathY) < gridSize / 2) {
          return false;
        }
      }
    }
    return true;
  }

  boolean towerAtPosition(int x, int y) {
    for (Tower t : towers) {
      if (dist(t.x, t.y, x, y) < gridSize / 2) {
        return true;
      }
    }
    return false;
  }
}
