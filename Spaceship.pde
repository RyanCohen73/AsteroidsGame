class Spaceship extends Floater {
  protected int mySpeedMag;
  protected int screenSizeX, screenSizeY;

  Spaceship(int screenSizeX, int screenSizeY) {
    this.screenSizeX = screenSizeX;
    this.screenSizeY = screenSizeY;

    //*
    this.corners = 14;
    this.xCorners = new int[]{25, 0, -10, 0, -15, -10, -15, -10, -15, -10, -15, 0, -10, 0};
    this.yCorners = new int[]{0, -5, -15, -15, -15, -15, -5, 0, 5, 15, 15, 15, 15, 5};
    //*/
    
    /* 
    //Attempted X-wing

    this.corners = 66;
    this.xCorners = new int[]{
      -24, -20, -20, -24, -24, -28, -28, -24, -24, -20
      -16, -19, -19, -4, -4, -1, -1, 23, 24, 24,
      27, 24, 24, 23, -1, -1, -4, -4, -2, -2,
      44, 44, 52, 52, 44, 44, -2, -2, -4, -4, 
      -1, -1, 23, 24, 24, 27, 24, 24, 23, -1,
      -1, -4, -4, -19, -19, -16, -20, -24, -24, -28,
      -28, -24, -24, -20, -20, -24
    };
    this.xCorners = new int[]{
      4, 6, 8, 8, 7, 8, 12, 13, 12, 12,
      32, 32, 36, 36, 37, 37, 35, 35, 36, 35,
      34, 33, 32, 33, 33, 31, 31, 13, 13, 6, 
      3, 4, 3, -3, -4, -3, -6, -13, -13, -31, 
      -31, -33, -33, -32, -33, -34, -35, -36, -35, -35, 
      -37, -37, -36, -36, -32, -32, -12, -12, -13, -12, 
      -8, -7, -8, -8, -6, -4
    };
    //*/

    this.rColor = 255;
    this.gColor = 255;
    this.bColor = 255;
    
    this.xCoord = this.screenSizeX/2;
    this.yCoord = this.screenSizeY/2;
    this.myXspeed = 0.0;
    this.myYspeed = 0.0;
    //this.mySpeedMag = Math.sqrt(this.myXspeed^2 + this.myYspeed^2);
    this.myPointDirection = 0.0;
  }
  
  
  public void stopMove() {
    this.myXspeed = 0.0;
    this.myYspeed = 0.0;
  }

  public void startingPos() {
    stopMove();
    this.xCoord = this.screenSizeX/2;
    this.yCoord = this.screenSizeY/2;
    this.myPointDirection = 0.0;
  }
  
  public void hyperspace() {
    stopMove();
    this.xCoord = Math.random()*this.screenSizeX;
    this.yCoord = Math.random()*this.screenSizeY;
    this.myPointDirection = Math.random()*360;
  }
 

  /*
  private void rotate(int angle) {
    this.myPointDirection = (this.myPointDirection + angle*(20))%360;
  }
  //*/
  public void rotateClockwise() {
    //this.rotate(1);
    turn(15);
  }
  public void rotateCounterClockwise() {
    //this.rotate(1);
    turn(-15);
  }
  
 
  /*
  public void accelerate(double constant) {
    super.accelerate(constant);
    
    //this.myXspeed += constant*Math.cos(this.myPointDirection*(2*Math.PI/360));
    //this.myXspeed = Math.max(0, this.myXspeed);
    
    //this.myYspeed += constant*Math.sin(this.myPointDirection*(2*Math.PI/360));
    //this.myYspeed = Math.max(0, this.myYspeed);
  }
  //*/

  /*
  public void move() {
    super.move();
    //this.xCoord = (this.xCoord + this.myXspeed + this.screenSizeX)%this.screenSizeX;
    //this.yCoord = (this.yCoord + this.myYspeed + this.screenSizeY)%this.screenSizeY ;
    //this.accelerate(-0.5);
  }
  //*/
}