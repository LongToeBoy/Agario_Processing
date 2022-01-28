Cell newCell;
ArrayList<Cell> cells;
int cellsCount=50;
int c=0;
void setup() {
  size(600, 600, P3D);
  genCells();
  //frameRate(1);
}

void draw() {
  background(255);
  noFill();
  stroke(255, 0, 0);
  circle(width/2, height/2, 600);
  for (int i=0; i<cells.size(); i++) {
    Cell cell=cells.get(i);

    cell.drawCell();
    cell.checkTouch(cells);
    cell.move();
    for (Cell cell1 : cells) {
      if (cell1!=cell&&sqrt(cell.getDistance(cell1))<10*cell.radius&&cell1.radius<cell.radius) {
        cell.chase(cell1.position);
        break;
      } else if (cell1!=cell)cell.runAway(cell1.position);
    }
    if (cell.radius<1) {
      cells.remove(cell);
      i--;
    }
  }

  if (cells.size>0) {
    Cell player=cells.get(cells.size()-1);
    //translate(player.position.x, player.position.y);
    player.chase(new Point((mouseX-width/2)*player.radius*7+player.position.x, (mouseY-height/2)*player.radius*7+player.position.y));
    player.move();
    println("("+mouseX+":"+mouseY+")");
    //camera(player.position.x,player.position.y,0,player.position.x,player.position.y,0,0,0,0);

    //camera(player.position.x, player.position.y, ((player.radius*7+1)/2.0) / tan(PI*30.0 / 180.0), player.position.x, player.position.y, 0, 0.0, 1.0, 0.0);
  }
}
void genCells() {
  cells=new ArrayList<Cell>();
  for (int i=0; i<cellsCount; i++) {
    cells.add(new Cell(new Point(random(width), random(height)), random(10, 30), color(random(255), random(255), random(255))));
  }
}
void mousePressed() {

  genCells();
}
