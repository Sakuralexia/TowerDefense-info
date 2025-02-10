class GridManager {
  int gridSize;
  boolean[][] pathGrid;
  int width, height;

  GridManager(int width, int height, int gridSize) {
    this.width = width;
    this.height = height;
    this.gridSize = gridSize;
    pathGrid = new boolean[width / gridSize][height / gridSize];
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

  void drawPath(ArrayList<Enemy> enemies) {
    stroke(150, 100, 50);  // Marrone per il percorso
    strokeWeight(10);
    noFill();

    for (Enemy e : enemies) {
      beginShape();
      for (int i = 0; i < e.path.length; i++) {
        vertex(e.path[i][0], e.path[i][1]);
      }
      endShape();
    }

    strokeWeight(1);  // Ripristina lo spessore normale
  }
  void updatePathGrid(ArrayList<Enemy> enemies) {
    for (int i = 0; i < pathGrid.length; i++) {
      for (int j = 0; j < pathGrid[i].length; j++) {
        pathGrid[i][j] = false;
      }
    }

    for (Enemy e : enemies) {
      for (int i = 0; i < e.path.length - 1; i++) {
        int[] start = e.path[i];
        int[] end = e.path[i + 1];

        int x1 = start[0] / gridSize;
        int y1 = start[1] / gridSize;
        int x2 = end[0] / gridSize;
        int y2 = end[1] / gridSize;

        markCellsAlongPath(x1, y1, x2, y2);
      }
    }
  }

  void markCellsAlongPath(int x1, int y1, int x2, int y2) {
    int dx = abs(x2 - x1);
    int dy = abs(y2 - y1);
    int sx = x1 < x2 ? 1 : -1;
    int sy = y1 < y2 ? 1 : -1;
    int err = dx - dy;

    while (true) {
      pathGrid[x1][y1] = true;
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

  boolean isValidPosition(int x, int y) {
    return !pathGrid[x][y];
  }
}
