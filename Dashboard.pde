class Dashboard {
  protected String gameStatus;
  protected int screenSizeX, screenSizeY, screenArea;
  protected double textDensity;
  protected Spaceship spaceship;
  protected int score, lastScore, highScore, lives, level, shieldsRemaining, asteroidsDestroyedCounter, shotsFiredCounter;

  Dashboard(String gameStatus, int screenSizeX, int screenSizeY, int screenArea, double textDensity, Spaceship spaceship, int score, int lastScore, int highScore, int lives, int level, int shieldsRemaining, int asteroidsDestroyedCounter, int shotsFiredCounter) {
    this.gameStatus = gameStatus;
    this.screenSizeX = screenSizeX;
    this.screenSizeY = screenSizeY;
    this.textDensity = textDensity;
    this.screenArea = screenArea;
    this.spaceship = spaceship;
    this.score = score; 
    this.lastScore = lastScore;
    this.highScore = highScore;
    this.lives = lives;
    this.level = level;
    this.shieldsRemaining = shieldsRemaining;
    this.asteroidsDestroyedCounter = asteroidsDestroyedCounter;
    this.shotsFiredCounter = shotsFiredCounter;
  }

  public void calcTextSize(double factor, int min) {
    int size = (int)(factor*this.textDensity*this.screenArea);
    if (size < min) {
      size = min;  
    }
    textSize(size);
  }

  public void createDock (String label, double input, int rowPos, int sizeAfter) {
    fill(255, 255, 255);
    calcTextSize((4/3), 10);
    //textSize(15);
    text(label + ": " + nf((float)input, 0, sizeAfter), 20, 20 + rowPos*15);
  }

  public void displayDock() {
    createDashboard("X Position", this.spaceship.getCenterX(), 0, 2);
    createDashboard("Y Position", this.spaceship.getCenterY(), 1, 2);
    createDashboard("Direction", this.spaceship.getPointDirection(), 2, 2);
    createDashboard("X Speed", this.spaceship.getXspeed(), 3, 2);
    createDashboard("Y Speed", this.spaceship.getYspeed(), 4, 2);

    createDashboard("High Score", (double) this.highScore, 6, 0);
    createDashboard("Score", (double) this.score, 7, 0);

    createDashboard("Lives Remaining", (double) this.lives, 9, 0);
    createDashboard("Level", (double) this.level+1, 10, 0);
    createDashboard("Shields Remaining", (double) this.shieldsRemaining, 11, 0);
  }

  public void createStat(String label, int input, int rowPos) {
    fill(255, 255, 255);
    
    calcTextSize((4/3), 10);
    //textSize(20);
    String string = label + " " + input;
    float textPosX = (this.screenSizeX - textWidth(string))/2;
    float textPosY = (3*this.screenSizeY)/5;

    text(string, textPosX, textPosY + rowPos*25);
  }

  public void displayStats() {
    //text();
    createStat("final score", this.lastScore, 0);
    createStat("highscore", this.highScore, 1);
    createStat("level", this.level, 3);
    createStat("asteroids destroyed", this.asteroidsDestroyedCounter, 4);
    createStat("shots fired", this.shotsFiredCounter, 5);

    
  }

  public void displayGameMessage(String label) {
    fill(255, 255, 255);
    
    calcTextSize(2, 15);
    //textSize(30); 
    float textPosX = (this.screenSizeX - textWidth(label))/2;
    int textPosY = this.screenSizeY/3;
    text(label, textPosX, textPosY); 
  }

  public void display() {
    if (this.gameStatus == "PLAYING") {
      displayDock();
    }
    else if (this.gameStatus == "LEVEL UP") {
      displayGameMessage("Level Cleared! Press ENTER to Continue");
    }
    else if (this.gameStatus == "BONUS LIFE") {
      displayGameMessage("+1 life");
    }
    else if (this.gameStatus == "GAME OVER") {
      displayGameMessage("GAME OVER - Press ENTER to Play Again");
      displayStats();
    }
  }
}