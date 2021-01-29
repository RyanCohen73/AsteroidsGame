class Asteroid extends Floater {
  
  protected double rotationSpeed;
  protected int screenSizeX, screenSizeY;
  protected String functionType;
  protected String sizeVariantType;
  protected int avgRadius;

  Asteroid(int screenSizeX, int screenSizeY, String functionType) {
    this.screenSizeX = screenSizeX;
    this.screenSizeY = screenSizeY;
    this.functionType = functionType;
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
  
  public String getFunctionType() {
    return this.functionType;
  }
  public String getSizeType() {
    return this.sizeVariantType;
  }

  public int  getAvgRadius() {
    return this.avgRadius
;
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
  }

  private void calcAvgRadius() {
    int value = 0;
    for (int i = 0; i < this.corners; i++) {
      int x = this.xCorners[i];
      int y = this.yCorners[i];
      value += Math.sqrt(x*x + y*y);
    }
    value = value/(this.corners);
    this.avgRadius = value;
    System.out.println(value);
  }
}