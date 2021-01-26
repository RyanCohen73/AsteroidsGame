class Lazer extends Floater {
  
  public Lazer(Spaceship spaceship) {
    this.myCenterX = spaceship.getCenterX();
    this.myCenterY = spaceship.getCenterY();
    
    this.myXspeed = spaceship.getXspeed();
    this.myYspeed = spaceship.getYspeed();

    this.myPointDirection = spaceship.getPointDirection();

    this.rColor = 255;
    this.gColor = 255;
    this.bColor = 255;

    accelerate(10);
  }

  //public void move()

  public void show() {
    fill(this.rColor, this.gColor, this.bColor);
    stroke(255, 255, 255);
    ellipse((float)this.myCenterX, (float)this.myCenterY, 5, 5);
  }
  public void move() { 
    this.myCenterX += this.myXspeed;    
    this.myCenterY += this.myYspeed; 
  } 

}