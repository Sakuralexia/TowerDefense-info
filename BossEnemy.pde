class BossEnemy extends Enemy {
  boolean deadEffectActive = false;
  float effectSize = 50; // Dimensione iniziale dell'effetto

  BossEnemy(int gridSize, float startX, float startY, SoundFile deathSound) {
    super(gridSize, startX, startY, deathSound);
    this.hp = 20; // Più vita del normale
  }

  @Override
  void takeDamage() {
    hp--;
    if (hp <= 0 && !isDead) {
      isDead = true;
      deathSound.play();
      deadEffectActive = true; // Attiva l'effetto della zona nera
    }
  }

  @Override
  void display() {
    if (isDead) {
      // Effetto della zona nera dopo la morte
      if (deadEffectActive) {
        fill(0, 50); // Nero semi-trasparente
        ellipse(x, y, effectSize, effectSize);
        effectSize -= 0.5; // Rimpicciolisce lentamente

        if (effectSize <= 0) {
          deadEffectActive = false; // L'effetto sparisce
        }
      }
      return;
    }

    // Cambia colore in base alla vita
    if (hp > 10) {
      fill(0, 255, 0);
    } else if (hp > 5) {
      fill(255, 165, 0);
    } else {
      fill(255, 0, 0);
    }

    ellipse(x, y, 30, 30); // Il boss è più grande
    fill(0);
    textAlign(CENTER);
    text(hp, x, y - 15);
  }
}
