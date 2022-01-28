class Cell {
  Point position;
  float radius;
  color celCol;
  Velocity velocity;
  float maxSpeed;
  float radExchange=1;
  Cell(Point position, float radius, color celCol) {
    this.position=position;
    this.radius=radius;
    this.maxSpeed=0.5;
    this.celCol=celCol;
    this.velocity=new Velocity(0, 0);
  }
  void calcRadius(){
    
  }
  void chase(Point point) {
    float dy=point.y-this.position.y;
    float dx=point.x-this.position.x;
    float distSq=dy*dy+dx*dx;
    this.velocity.direction=atan2(dy, dx);
    this.velocity.speed=distSq*this.maxSpeed/(distSq+this.maxSpeed);
  }
  void runAway(Point point){
    float dy=point.y-this.position.y;
    float dx=point.x-this.position.x;
    float distSq=dy*dy+dx*dx;
    float dy1=height/2-this.position.y;
    float dx1=width/2-this.position.x;
    
    this.velocity.direction=(atan2(dy1,dx1)-atan2(dy, dx));
    this.velocity.speed=(distSq+this.maxSpeed)/distSq*this.maxSpeed;
  }
  void move() {
    this.position.x+=this.velocity.speed*cos(this.velocity.direction);
    this.position.y+=this.velocity.speed*sin(this.velocity.direction);
  }
  void drawCell() {
    fill(this.celCol);
    noStroke();
    circle(this.position.x, this.position.y, this.radius);
  }
  float getDistance(Cell other){
    float dy=this.position.y-other.position.y;
    float dx=this.position.x-other.position.x;
    return(dy*dy+dx*dx);
  }
  float getDirection(Cell other){
    float dy=this.position.y-other.position.y;
    float dx=this.position.x-other.position.x;
    return(atan2(dy,dx));
  }
  void checkTouch(ArrayList<Cell> cells1){
    ArrayList<Cell> cells=new ArrayList<Cell>(cells1);
    cells.remove(this);
    float dy=this.position.y-height/2;
    float dx=this.position.x-width/2;
    float dist=sqrt(dy*dy+dx*dx);
    if(dist+this.radius/2>width/2){
      
      this.radius-=abs(dist+this.radius/2-width/2);
      return;
    }
    for(Cell cell:cells){
      dist=getDistance(cell);
      float radSum=this.radius+cell.radius;
      if(dist<radSum*radSum/4){
        float alpha=getDirection(cell);//-this.velocity.direction;
        this.velocity.speed=abs(sqrt(dist)-radSum/2);
        this.velocity.direction+=PI;
        if(this.radius<cell.radius){
          this.radius-=cell.radExchange;
        }
        else if(this.radius>cell.radius){
          this.radius+=this.radExchange;
        }
         //this.maxSpeed=100/this.radius;

      }
      
    }
    
  }
}
