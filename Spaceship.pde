class Spaceship extends Floater {
    //your code here
  protected int mySpeedMag;
  Spaceship() {
    this.corners = 14;
    this.xCorners = new int[]{25, 0, -10, 0, -15, -10, -15, -10, -15, -10, -15, 0, -10, 0};
    this.yCorners = new int[]{0, -5, -15, -15, -15, -15, -5, 0, 5, 15, 15, 15, 15, 5};
    /*this.corners = 66;
    this.xCorners = new int[]{
      -12, -10, -10, -12, -12, -14, -14, -12, -12, -10
      -8, -9.5, -9.5, -2, -2, -0.5, -0.5, 11.5, 12, 12,
      13.5, 12, 12, 11.5, -0.5, -0.5, -2, -2, -1, -1,
      22, 22, 26, 26, 22, 22, -1, -1, -2, -2, 
      -0.5, -0.5, 11.5, 12, 12, 13.5, 12, 12, 11.5, -0.5,
     -0.5, -2, -2, -9.5, -9.5, -8, -10, -12, -12, -14,
      -14, -12, -12, -10, -10, -12
    };
    this.xCorners = new int[]{
      2, 3, 4, 4, 3.5, 4, 6, 6.5, 6, 6,
      16, 16, 18, 18, 18.5, 18.5, 17.5, 17.5, 18, 17.5,
      17, 16.5, 16, 16.5, 16.5, 15.5, 15.5, 6.5, 6.5, 3, 
      1.5, 2, 1.5, -1.5, -2, -1.5, -3, -6.5, -6.5, -15.5, 
      -15.5, -16.5, -16.5, -16, -16.5, -17, -17.5, -18, -17.5, -17.5, 
      -18.5, -18.5, -18, -18, -16, -16, -6, -6, -6.5, -6, 
      -4, -3.5, -4, -4, -3, -2
    };
    */
    this.myColor = 255;
    this.myCenterX = 250;
    this.myCenterY = 250;
    this.myXspeed = 0.0;
    this.myYspeed = 0.0;
    //this.mySpeedMag = Math.sqrt(this.myXspeed^2 + this.myYspeed^2);
    this.myPointDirection = 0.0;
  }
  
  public void hyperspace() {
    this.myXspeed = 0.0;
    this.myYspeed = 0.0;
    this.myCenterX = Math.random()*500;
    this.myCenterY = Math.random()*500;
    this.myPointDirection = Math.random()*360;
  }
  private void rotate(int angle) {
    this.myPointDirection = (this.myPointDirection + angle*(15))%360;
  }
  public void rotateClockwise() {
    this.rotate(1);
  }
  public void rotateCounterClockwise() {
    this.rotate(-1);
  }
  public void accelerate(double constant) {
    this.myXspeed += constant*Math.cos(this.myPointDirection*(2*Math.PI/360));
    //this.myXspeed = Math.max(0, this.myXspeed);
    
    this.myYspeed += constant*Math.sin(this.myPointDirection*(2*Math.PI/360));
    //this.myYspeed = Math.max(0, this.myYspeed);
  }
  public void move() {
    this.myCenterX = (this.myCenterX + this.myXspeed + 500)%500;
    this.myCenterY = (this.myCenterY + this.myYspeed + 500)%500;
    //this.accelerate(-0.5);
  }

}
