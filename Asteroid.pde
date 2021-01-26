class Asteroid extends Floater {
  
  protected double rotationSpeed;
  protected int screenSizeX, screenSizeY;
  //private int 

  Asteroid(int screenSizeX, int screenSizeY) {
    this.screenSizeX = screenSizeX;
    this.screenSizeY = screenSizeY;
    
    //initAsteroidVariant(1);
    initAsteroidVariant(round((float)(Math.random())));
    
    this.rColor = (int)(Math.random()*255);
    this.gColor = (int)(Math.random()*255);
    this.bColor = (int)(Math.random()*255);

    this.myCenterX = (double) Math.random()*this.screenSizeX;
    this.myCenterY = (double) Math.random()*this.screenSizeY;
    
    this.myXspeed = genNegValue()*((double) 1 + Math.random()*1.5);
    this.myYspeed = genNegValue()*((double) 1 + Math.random()*1.5);
    
    this.myPointDirection = 0.0;
    this.rotationSpeed = (double) (Math.random()*4);
  }
  
  public void move() {
    this.turn(this.rotationSpeed);
    super.move();
  }

  private int genNegValue() {
    return round((float)Math.random()) == 1 ? -1 : 1;
  }

  private int genRandomValue(int input) {
    int value = input+(int)(Math.random()*15);
    return value;
  }

  private void initAsteroidVariant(int selector) {
    
    if (selector == 0) {
      //triangles
      this.corners = 3;
      int value = 10;
      this.xCorners = new int[]{genRandomValue(value), -1*genRandomValue(value), genNegValue()*genRandomValue(value)};
      this.yCorners = new int[]{-1*genRandomValue(value), -1*genRandomValue(value), genRandomValue(value)};
    }  else if (selector == 1) {
      //polygons
      this.corners = 4;
      int value = 5;
      this.xCorners = new int[]{genRandomValue(value), genRandomValue(value), -1*genRandomValue(value), -1*genRandomValue(value)};
      this.yCorners = new int[]{genRandomValue(value), -1*genRandomValue(value), -1*genRandomValue(value), genRandomValue(value)};
    }
  }
  
  /*
  private void initAsteroidVariant() {
    this.corners = 4;
    int value = 5;
    this.xCorners = new int[]{genRandomValue(value), genRandomValue(value), -1*genRandomValue(value), -1*genRandomValue(value)};
    this.yCorners = new int[]{genRandomValue(value), -1*genRandomValue(value), -1*genRandomValue(value), genRandomValue(value)};
  }
  //*/
  /*
  private void initAsteroidVariant(int selector) {
    if (selector == 0) {
      this.corners = 6;
      this.xCorners = new int[]{13, 6, -11, -5, -11, 7};
      this.yCorners = new int[]{0, 10, 8, 0, -8, -8};
    } else if (selector == 1) {
      this.corners = 10;
      this.xCorners = new int[]{10, 11, 5, -7, -10, 0, 1, -12, -3, 2};
      this.yCorners = new int[]{5, 0, -3, -2, -1, 2, 4, 5, 11, 10};
    } else if (selector == 2) {
      this.corners = 4;
      int value = 5;
      this.xCorners = new int[]{genRandomValue(value), genRandomValue(value), -1*genRandomValue(value), -1*genRandomValue(value)};
      this.yCorners = new int[]{genRandomValue(value), -1*genRandomValue(value), -1*genRandomValue(value), genRandomValue(value)};
    }
  }
  //*/

}