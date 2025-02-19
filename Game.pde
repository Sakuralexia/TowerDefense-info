import processing.sound.*;

class Game {
  ArrayList<Enemy> enemies;
  ArrayList<Tower> towers;
  ArrayList<Bullet> bullets;
  GridManager gridManager;
  ErrorManager errorManager;
  PositionManager positionManager;
  int points;
  int lives;
  int gridSize = 40;
  int wave = 1;
  int enemiesLeftToSpawn;
  int spawnTimer = 0;
  boolean waveActive = false;

  SoundFile deathSound;

  Game(SoundFile deathSound) {
    enemies = new ArrayList<>();
    towers = new ArrayList<>();
    bullets = new ArrayList<>();
    gridManager = new GridManager(width, height, gridSize);
    errorManager = new ErrorManager();
    positionManager = new PositionManager(gridSize, gridManager, towers);

    points = 100;
    lives = 10;
    this.deathSound = deathSound;

    startNewWave();
  }

  void setDeathSound(SoundFile sound) {
    this.deathSound = sound;
  }

  void startNewWave() {
    waveActive = true;
    enemiesLeftToSpawn = min(5 + wave * 2, 30); // Incrementa il numero di nemici ogni onda
    spawnTimer = 0;
  }

  void update() {
    if (wave > 10) {
      victory();
      return;
    }

    if (waveActive) {
      if (enemiesLeftToSpawn > 0 && spawnTimer % 60 == 0) {
        if (wave > 3 && random(1) < 0.2 + (wave * 0.02)) { 
          enemies.add(new SlowEnemy(gridSize, gridSize / 2, gridSize / 2, deathSound)); 
        } else {
          enemies.add(new Enemy(gridSize, gridSize / 2, gridSize / 2, deathSound)); 
        }
        enemiesLeftToSpawn--;
      }
      spawnTimer++;

      if (enemies.isEmpty() && enemiesLeftToSpawn == 0) {
        wave++;
        startNewWave();
      }
    }

    gridManager.updatePathGrid(enemies);
    errorManager.update();

    for (Tower t : towers) {
      t.shoot(enemies, bullets);
    }

    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy e = enemies.get(i);
      e.move();

      if (e.hp <= 0) {
        enemies.remove(i);
        deathSound.play();
        points += (e instanceof SlowEnemy) ? 10 : 7;
      } else if (e.step == e.path.length - 1) {
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

    // Disegna la griglia e il percorso
    gridManager.drawGrid();
    gridManager.drawPath(enemies);

    // Mostra gli errori, le torri, i nemici e i proiettili
    errorManager.showErrorMessage();

    for (Tower t : towers) {
      t.display();
    }

    for (Enemy e : enemies) {
      e.display();
    }

    for (Bullet b : bullets) {
      b.display();
    }

    // Mostra informazioni sul gioco
    fill(0);
    textSize(16);
    textAlign(RIGHT, TOP);
    text("Punti: " + points, width - 10, 10);
    text("Ondata: " + wave, width - 10, 30);
    text("Vite: " + lives, width - 10, 50);
    text("Costo torre: " + 50, width - 10, 70);
  }

  void gameOver() {
    noLoop();
    textSize(32);
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width / 2, height / 2);
  }

  void victory() {
    noLoop();
    textSize(32);
    fill(0, 200, 0);
    textAlign(CENTER, CENTER);
    text("HAI VINTO!", width / 2, height / 2);
  }

  void placeTower(int x, int y) {
    int gridX = floor(x / gridSize);
    int gridY = floor(y / gridSize);

    // Calcola il centro del quadrato della griglia
    int centerX = gridX * gridSize + gridSize / 2;
    int centerY = gridY * gridSize + gridSize / 2;

    if (points >= 50 && positionManager.isPositionValid(centerX, centerY)) {
      towers.add(new Tower(centerX, centerY));
      points -= 50;
    } else {
      errorManager.setErrorMessage("Non puoi piazzare una torre qui!", 180);
    }
  }
}
