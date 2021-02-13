class Shield extends Floater{

  Shield(Spaceship spaceship) {
    this.xCoord = spaceship.getCenterX();
    this.yCoord = spaceship.getCenterY();
    this.rColor = 204;
    this.gColor = 102;
    this.bColor = 0;
  }
  
  public double getCenterX() {
    return this.xCoord;
  }
  public double getCenterY() {
    return this.yCoord;
  }


  public void show() {
    fill(this.rColor, this.gColor, this.bColor, 50);    
    stroke(this.rColor, this.gColor, this.bColor, 50); 
    ellipse((float)xCoord, (float)yCoord, 150, 150);
    //*/
  }
  

}