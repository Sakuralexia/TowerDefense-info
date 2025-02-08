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
  boolean[][] pathGrid;
  String errorMessage = "";
  int errorMessageTimer = 0;

  Game() {
    enemies = new ArrayList<Enemy>();
    towers = new ArrayList<Tower>();
    bullets = new ArrayList<Bullet>();
    points = 100;
    lives = 10;
    initializePathGrid();
    startNewWave();
  }

  void initializePathGrid() {
    pathGrid = new boolean[width / gridSize][height / gridSize];
    updatePathGrid();
  }

  void updatePathGrid() {
  // Resetta la griglia a false
  for (int i = 0; i < pathGrid.length; i++) {
    for (int j = 0; j < pathGrid[i].length; j++) {
      pathGrid[i][j] = false;
    }
  }

  // Segna come "occupate" le celle lungo il percorso dei nemici
  for (Enemy e : enemies) {
    for (int i = 0; i < e.path.length - 1; i++) {
      int[] start = e.path[i];
      int[] end = e.path[i + 1];
      
      // Calcoliamo i punti intermedi tra i due
      int x1 = start[0] / gridSize;
      int y1 = start[1] / gridSize;
      int x2 = end[0] / gridSize;
      int y2 = end[1] / gridSize;

      // Disegna una "linea" tra i due punti (x1, y1) e (x2, y2) e segna le celle
      markCellsAlongPath(x1, y1, x2, y2);
    }
  }
}

void markCellsAlongPath(int x1, int y1, int x2, int y2) {
  // Utilizza la bresenham line algorithm per segnare tutte le celle
  int dx = abs(x2 - x1);
  int dy = abs(y2 - y1);
  int sx = x1 < x2 ? 1 : -1;
  int sy = y1 < y2 ? 1 : -1;
  int err = dx - dy;

  while (true) {
    // Segna la cella attuale come occupata
    pathGrid[x1][y1] = true;

    // Se siamo arrivati alla fine del percorso, usciamo
    if (x1 == x2 && y1 == y2) break;

    int e2 = err * 2;
    if (e2 > -dy) {
      err -= dy;
      x1 += sx;
    }
    if (e2 < dx) {
      err += dx;
      y1 += sy;
    }
  }
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

    updatePathGrid();

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

    if (errorMessageTimer > 0) {
      showErrorMessage();
      errorMessageTimer--;
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

    if (errorMessageTimer > 0) {
      showErrorMessage();
    }
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

  boolean isValidPosition(int gridX, int gridY) {
  // Verifica che la posizione non sia lungo il percorso dei nemici
  return !pathGrid[gridX][gridY];
}

void placeTower(int x, int y) {
  int gridX = floor(x / gridSize);
  int gridY = floor(y / gridSize);

  // Verifica che la posizione sia valida (non lungo il percorso del nemico)
  if (gridX >= 0 && gridX < width / gridSize && gridY >= 0 && gridY < height / gridSize && points >= 50 && isValidPosition(gridX, gridY) && !towerAtPosition(gridX, gridY)) {
    towers.add(new Tower(gridX * gridSize + gridSize / 2, gridY * gridSize + gridSize / 2));
    points -= 50;
  } else if (!isValidPosition(gridX, gridY)) {
    errorMessage = "Non puoi piazzare una torre sul percorso del nemico!";
    errorMessageTimer = 180; // Durata del messaggio di errore in frame
  }
}

  boolean towerAtPosition(int x, int y) {
    for (Tower t : towers) {
      if (dist(t.x, t.y, x, y) < gridSize / 2) {
        return true;
      }
    }
    return false;
  }

  void showErrorMessage() {
    fill(255, 0, 0);  // Colore rosso
    textSize(16);
    textAlign(CENTER, TOP);
    text(errorMessage, width / 2, 10);  // Posizione in alto al centro
  }
}
