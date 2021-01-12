class Star {
  private int xCoord, yCoord;
  private int rColor;
  private int gColor;
  private int bColor;
  private int starSize;

  public Star() {
    this.xCoord = (int)(Math.random()*500);
    this.yCoord = (int)(Math.random()*500);
    
    this.rColor = (int)(Math.random()*255);
    this.gColor = (int)(Math.random()*255);
    this.bColor = (int)(Math.random()*255);
    
    this.starSize = (int)(Math.random()*5);
  }
  
  public void show() {
    fill(rColor, gColor, bColor); 
    ellipse(xCoord, yCoord, starSize + (int)(Math.random()*2), starSize + (int)(Math.random()*2));
  }
}
