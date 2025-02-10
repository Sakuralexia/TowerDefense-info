class PositionManager {
  int gridSize;
  GridManager gridManager;
  ArrayList<Tower> towers;

  PositionManager(int gridSize, GridManager gridManager, ArrayList<Tower> towers) {
    this.gridSize = gridSize;
    this.gridManager = gridManager;
    this.towers = towers;
  }

  boolean isPositionValid(int x, int y) {
    int gridX = floor(x / gridSize);
    int gridY = floor(y / gridSize);
    return gridManager.isValidPosition(gridX, gridY) && !towerAtPosition(gridX, gridY);
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
