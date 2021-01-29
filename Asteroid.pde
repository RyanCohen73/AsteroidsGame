class Asteroid extends Floater {
  
  protected double rotationSpeed;
  protected int screenSizeX, screenSizeY;
  protected String type;
  protected String sizeVariantType;
  //private int 

  Asteroid(int screenSizeX, int screenSizeY, String type) {
    this.screenSizeX = screenSizeX;
    this.screenSizeY = screenSizeY;
    this.type = type;
    //initAsteroidVariant(1);
    initAsteroidVariant(round((float)(Math.random())), round((float)(Math.random())));
    
    this.rColor = (int)(Math.random()*255);
    this.gColor = (int)(Math.random()*255);
    this.bColor = (int)(Math.random()*255);

    genStartPoint();
    
    this.myXspeed = genNegValue()*((double) 1 + Math.random()*1.5);
    this.myYspeed = genNegValue()*((double) 1 + Math.random()*1.5);
    
    this.myPointDirection = 0.0;
    this.rotationSpeed = (double) (Math.random()*4);
  }
  
  public String getType() {
    return this.type;
  }
  public String getSizeType() {
    return this.sizeVariantType;
  }
  
  public void genStartPoint() {
    this.myCenterX = (double) Math.random()*this.screenSizeX;

    if ((this.screenSizeX-30) < this.myCenterX 
    && this.myCenterX < (this.screenSizeX+30)) {
      this.myCenterX = this.screenSizeX+genNegValue()*(this.screenSizeX/3);
    }
    
    this.myCenterY = (double) Math.random()*this.screenSizeY;

    if ((this.screenSizeY-30) < this.myCenterY 
    && this.myCenterY < (this.screenSizeY+30)) {
      this.myCenterY = this.screenSizeY+genNegValue()*(this.screenSizeY/3);
    }
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

  private String genShapeValue(int selector) {
    return selector == 0 ? "rock" : "boulder";
  }

  private int sizeForSizeVariant(String sizeVariantType) {
    switch (sizeVariantType) {
      case "boulder":
        return 30;
      case "rock":
      default:
        return 10;
    }
  }

  private void initAsteroidVariant(int selectorA, int selectorB) {
    this.sizeVariantType = genShapeValue(selectorB);
    int value = sizeForSizeVariant(this.sizeVariantType);
    if (selectorA == 0) {
      //triangles
      this.corners = 3;
      
      
      this.xCorners = new int[]{genRandomValue(value), -1*genRandomValue(value), genNegValue()*genRandomValue(value)};
      this.yCorners = new int[]{-1*genRandomValue(value), -1*genRandomValue(value), genRandomValue(value)};
    }  
    else if (selectorA == 1) {
      //polygons
      this.corners = 4;
    
      this.xCorners = new int[]{genRandomValue(value), genRandomValue(value), -1*genRandomValue(value), -1*genRandomValue(value)};
      this.yCorners = new int[]{genRandomValue(value), -1*genRandomValue(value), -1*genRandomValue(value), genRandomValue(value)};
    }
    
    /*
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
    //*/
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