class Star {
  private int xCoord, yCoord;
  private int rColor, gColor, bColor;
  private int starSize;
  protected int screenSizeX, screenSizeY;

  public Star(int screenSizeX, int screenSizeY) {
    this.screenSizeX = screenSizeX;
    this.screenSizeY = screenSizeY;

    this.xCoord = (int)(Math.random()*this.screenSizeX);
    this.yCoord = (int)(Math.random()*this.screenSizeY);
    
    this.rColor = (int)(Math.random()*255);
    this.gColor = (int)(Math.random()*255);
    this.bColor = (int)(Math.random()*255);
    
    this.starSize = (int)(Math.random()*5);
  }
  
  public void show() {
    fill(this.rColor, this.gColor, this.bColor);
    stroke(this.rColor, this.gColor, this.bColor); 
    ellipse(this.xCoord, this.yCoord, this.starSize + (int)(Math.random()*2), this.starSize + (int)(Math.random()*2));
  }
}