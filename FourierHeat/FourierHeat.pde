Grid[][] grid; // Store current temperatures of each area in the grid. Red (warmer) colors indicate higher temperatures. Blue (cooler) colors indicate lower temperatures.
final float k = 0.15; // Coefficient of heat conductivity (Low values indicate less heat transfer; high values mean more transfer. Constant should be kept relatively low for this model.)
final int d = 5; // Density (Larger density means greater grid size; smaller density means smaller grid size. Density should not exceed the size of window.)
final float max = 100000000; // Maximum temperature of the initial heat spots. (Preferably kept at higher values.)

// Initiailize the model
void setup() {
  noStroke();
  colorMode(HSB,360,100,100);
  size(600,600);
  grid = new Grid[width/d][height/d];
  for (int x = 0; x < width/d; x++) {
    for (int y = 0; y < width/d; y++) {
      if (sqrt(sq(x-width/4/d)+sq(y-height/4/d)) < 100/d || sqrt(sq(x-3*width/4/d)+sq(y-3*height/4/d)) < 100/d) {
        grid[x][y] = new Grid(max);
      }
      else {
        grid[x][y] = new Grid(1);
      }
    }
  }
}

// Update colors of grid
void draw() {
  // Get current grid
  Grid[][] gTemp = copy(grid);
  for (int x = 0; x < width/d; x++) {
    for (int y = 0; y < height/d; y++) {
      for (int i = -1; i <= 1; i += 2) {
        for (int j = -1; j <= 1; j += 2) {
          // Check for bounds
          if (x+i != -1 && y+j != -1 && x+i != grid.length && y+j!= grid[0].length) {
            float l = sqrt(sq(i)+sq(j));
            float c = gTemp[x][y].gt()-gTemp[x+i][y+j].gt();
            grid[x+i][y+j].st(grid[x+i][y+j].gt()+k*c/l);
            grid[x][y].st(grid[x][y].gt()-k*c/l);
          }
        }
      }
    }
  }
  sketch(grid);
}

// Sketch new state
void sketch(Grid[][] m) { 
  for (int x = 0; x < m.length; x++) {
    for (int y = 0; y < m[0].length; y++) {
      fill(map(m[x][y].gt(),0,max,240,0),100,100);
      rect(x*d,y*d,(x+1)*d,(y+1)*d);
    }
  }  
}

// Copy current Grid
Grid [][] copy(Grid [][] m) {
  Grid[][] newGrid = new Grid[m.length][m[0].length];
  for (int x = 0; x < newGrid.length;x++) {
    for (int y = 0; y < newGrid[x].length; y++) {
      newGrid[x][y] = new Grid(m[x][y].gt());
    }
  }
  return newGrid;
}
