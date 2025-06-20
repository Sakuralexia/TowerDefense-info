import processing.sound.*;

class Game {
  ArrayList<Enemy> enemies;
  ArrayList<Tower> towers;
  ArrayList<Bullet> bullets;
  GridManager gridManager;
  ErrorManager errorManager;
  PositionManager positionManager;
  int points,lives;
  int gridSize = 40;
  int wave = 1;
  float enemiesLeftToSpawn;
  int spawnTimer = 0;
  boolean waveActive = false;
  boolean gameOver = false;
  boolean gameWon = false;
  int towerCost = 40; // Costo iniziale ridotto
  int towerCostIncrease = 12; // Incremento più graduale

  SoundFile deathSound;

  Game(SoundFile deathSound) {
    enemies = new ArrayList<>();
    towers = new ArrayList<>();
    bullets = new ArrayList<>();
    gridManager = new GridManager(width, height, gridSize);
    errorManager = new ErrorManager();
    positionManager = new PositionManager(gridSize, gridManager, towers);

    points = 120; // Punti iniziali ridotti
    lives = 10;
    this.deathSound = deathSound;

    startNewWave();
  }

  void setDeathSound(SoundFile sound) {
    this.deathSound = sound;
  }

  void startNewWave() {
    waveActive = true;
    if (wave == 10) {
        // L'ultima ondata ha solo un Boss
        enemiesLeftToSpawn = 1;
    } else {
        enemiesLeftToSpawn = min(3 + wave * 3, 25);
    }
    spawnTimer = 0;
  }

void update() {
    if (gameOver || gameWon) return;

    if (lives <= 0) {
        gameOver();
        return;
    }
    if (wave > 10 && enemies.isEmpty() && enemiesLeftToSpawn == 0) {
        victory();
        return;
    }
    if (waveActive && enemiesLeftToSpawn > 0 && spawnTimer % 60 == 0) {
        spawnEnemy();
        enemiesLeftToSpawn--;
    }
    spawnTimer++;
    if (waveActive && enemies.isEmpty() && enemiesLeftToSpawn == 0) {
        if (++wave <= 10) startNewWave();
    }

    gridManager.updatePathGrid(enemies);
    errorManager.update();
    for (Tower t : towers) t.shoot(enemies, bullets);

    for (int i = enemies.size() - 1; i >= 0; i--) {
        Enemy e = enemies.get(i);
        e.move();
        if (e.hp <= 0) {
            enemies.remove(i);
            deathSound.play();
            points += (e instanceof SlowEnemy) ? 8 : (e instanceof FastEnemy) ? 7 : 6;
        } else if (e.step == e.path.length - 1) {
            enemies.remove(i);
            if (--lives <= 0) {
                gameOver();
                return;
            }
        }
    }

    bullets.removeIf(b -> {
        b.move();
        return b.hit;
    });
}

void spawnEnemy() {
    if (wave == 10) {
        enemies.add(new BossEnemy(gridSize, gridSize / 2, gridSize / 2, deathSound));
    } else {
        float rand = random(1);
        if (wave > 5 && rand < 0.15 + (wave * 0.01)) {
            enemies.add(new FastEnemy(gridSize, gridSize / 2, gridSize / 2, deathSound));
        } else if (wave > 3 && rand < 0.2 + (wave * 0.02)) {
            enemies.add(new SlowEnemy(gridSize, gridSize / 2, gridSize / 2, deathSound));
        } else {
            enemies.add(new Enemy(gridSize, gridSize / 2, gridSize / 2, deathSound));
        }
    }
}


void display() {
    background(255);
    gridManager.drawGrid();
    gridManager.drawPath(enemies);
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

    fill(0);
    textSize(16);
    textAlign(RIGHT, TOP);
    text("Punti: " + points, width - 10, 10);
    text("Ondata: " + wave, width - 10, 30);
    text("Vite: " + lives, width - 10, 50);
    text("Costo torre: " + towerCost, width - 10, 70);

    // Mostra il messaggio di vittoria o game over
    if (gameOver) {
        textSize(32);
        fill(255, 0, 0);
        textAlign(CENTER, CENTER);
        text("GAME OVER", width / 2, height / 2);
    } else if (gameWon) {
        textSize(32);
        fill(0, 200, 0);
        textAlign(CENTER, CENTER);
        text("HAI VINTO!", width / 2, height / 2);
    }
  }

  void gameOver() {
    gameOver = true; 
    noLoop();
  }

  void victory() {
    gameWon = true; 
    noLoop();
  }

  void placeTower(int x, int y) {
    int gridX = floor(x / gridSize);
    int gridY = floor(y / gridSize);
    int centerX = gridX * gridSize + gridSize / 2;
    int centerY = gridY * gridSize + gridSize / 2;

    if (points >= towerCost && positionManager.isPositionValid(centerX, centerY)) {
      towers.add(new Tower(centerX, centerY));
      points -= towerCost;
      towerCost += towerCostIncrease; // Incremento più graduale
    } else {
      errorManager.setErrorMessage("Non puoi piazzare una torre qui o in questo momento!", 180);
    }
  }
}
