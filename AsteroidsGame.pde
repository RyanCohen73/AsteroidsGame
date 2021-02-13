public int screenSizeX, screenSizeY;
public int screenArea;

public String gameStatus;

public int score = 0;
public int highScore = 0;

public int level = 0;
public int lives = 5;
public int shieldsRemaining = 5;
public boolean canLevelUp = false;
public boolean isDead = false;


public int asteroidsDestroyedCounter = 0;
public int shotsFiredCounter = 0;

public double starDensity = 0.0005;
public double asteroidDensity = 0.00002;
public double textDensity = 0.00002;
public int numofStars, numofAsteroids;

Dashboard dashboard;
Spaceship spaceship;
Star[] stars;

ArrayList<Asteroid> asteroidList = new ArrayList<Asteroid>();
ArrayList<Asteroid> destroyedBouldersList = new ArrayList<Asteroid>();

ArrayList<Asteroid> extraLifeList = new ArrayList<Asteroid>();

ArrayList<Shield> shieldList = new ArrayList<Shield>();

ArrayList<Lazer> lazerList = new ArrayList<Lazer>();

//GAME METHODS 

public void clearScreen() {
  destroyLazers();
  destroyShields();
  destroyAsteroids();
}

public void startGame() {
  clearScreen();
  createAsteroids(0);
  this.gameStatus = "PLAYING";
  this.spaceship.startingPos();
  this.score = 0;
  this.level = 0;
  this.lives = 5;
  this.shieldsRemaining = 5;
  this.canLevelUp = false;
  this.isDead = false;
  this.asteroidsDestroyedCounter = 0;
}

public void isGameOver() {
  if (this.lives == 0) {
    this.gameStatus = "GAME OVER";
    this.isDead = true;

    /*/
    displayGameMessage("GAME OVER - Press ENTER to Play Again");
    displayStats();
    //*/
    clearScreen();
    this.spaceship.startingPos();
    
  }
}

public void instantKill() {
  this.lives = 0;
}

public void increaseScore(int amount){
  if (score == highScore){
    this.highScore += amount;
  }
  this.score += amount;
}

public void islevelCleared() {
  if (this.asteroidList.size() == 0 && this.lives != 0) {
    this.gameStatus = "LEVEL UP";
    this.canLevelUp = true;
    //displayGameMessage("Level Cleared! Press ENTER to Continue");
    clearScreen();
    this.spaceship.startingPos();
  }
}

public void levelUp() {
  this.gameStatus = "PLAYING";
  this.level ++;
  increaseScore(200);

  destroyLazers();
  destroyShields();
  createAsteroids(this.level);
  
  //this.spaceship.startingPos();
  this.spaceship.stopMove();
}

//STAR METHODS
public void createStars() {
  for (int i = 0; i < this.stars.length; i++){
    stars[i] = new Star(this.screenSizeX, this.screenSizeY);
  }
}

public void displayStars() {
  for (int i = 0; i < stars.length; i++){
    stars[i].show();
  }
}


//ASTEROID METHODS
public void createAsteroids(int input) {
  int numofAsteroids = this.numofAsteroids + input;
  for(int i = 0; i < numofAsteroids; i++){
    asteroidList.add(new Asteroid(this.screenSizeX, this.screenSizeY, "asteroid"));
  }
}

public void destroyAsteroids() {
  for (int i = this.asteroidList.size(); i > 0; i--){
    Asteroid asteroid = this.asteroidList.get(i-1);
    this.asteroidList.remove(i-1);

  }
}

public void displayAsteroids(){
  scatterBoulders();

  for (int j = this.asteroidList.size(); j > 0; j--) {
    Asteroid asteroid = this.asteroidList.get(j-1);
    if (this.shieldList.size() == 1) {
      if (detectCollision(this.shieldList.get(0), asteroid, 75)){
      //if (detectCollision(this.spaceship, asteroid, asteroid.getAvgDist())){
        this.asteroidList.remove(j-1);
      }
      asteroid.move();
      asteroid.show();
    }
    else if (detectCollision(this.spaceship, asteroid, 25)){
    //if (detectCollision(this.spaceship, asteroid, asteroid.getAvgDist())){

      if (asteroid.getFunctionType() == "asteroid") {
        this.asteroidList.remove(j-1);
        this.score = 0;
        this.lives --;
      } 
      else {
        this.asteroidList.remove(j-1);
        this.lives += 1;
      }
    }
    else {
      //displayLazers(asteroid, j);
      asteroid.move();
      asteroid.show();
    }
  }
}

public void scatterBoulders() {
  for (int i = this.destroyedBouldersList.size(); i > 0; i--) {
    Asteroid boulder = this.destroyedBouldersList.get(i-1);
    for(int j = 0; j < 5; j++) {
      asteroidList.add(new Asteroid(this.screenSizeX, this.screenSizeY, boulder.getCenterX(), boulder.getCenterY(), "asteroid", "rock"));
    }
    this.destroyedBouldersList.remove(i-1);
  }
}

//LAZER METHODS
public void destroyLazers() {
  for (int i = this.lazerList.size(); i > 0; i--){
    Lazer lazer = this.lazerList.get(i-1);
    this.lazerList.remove(i-1);
  }
}

public void displayLazers() {
  maintainLazers();
  for (int i = this.lazerList.size(); i > 0; i--){
    Lazer lazer = this.lazerList.get(i-1);
    
    for (int j = this.asteroidList.size(); j > 0; j--) {
      Asteroid asteroid = this.asteroidList.get(j-1);
      if (detectCollision(lazer, asteroid, 25)){
      //if (detectCollision(lazer, asteroid, asteroid.getAvgDist())){
        if (asteroid.getSizeType() == "boulder") {
          this.destroyedBouldersList.add(asteroid);
        }
        this.asteroidList.remove(j-1);
        this.lazerList.remove(i-1);
        increaseScore(100);
        this.asteroidsDestroyedCounter ++;
        System.out.println(asteroid.getAvgRadius());
        break;
      }
    }
    
    lazer.move();
    lazer.show();
    removeLazerWrapAround(lazer, i);
  }
  
  
}

public void removeLazerWrapAround(Lazer lazer, int i) {
  if (lazer.getCenterX() <= 0 || lazer.getCenterX() >= this.screenSizeX ||
    lazer.getCenterY() <= 0 || lazer.getCenterY() >= this.screenSizeY) {
    this.lazerList.remove(i-1);
  }
}

public void maintainLazers() {
  if (this.lazerList.size() >= 5) {
    this.lazerList.remove(0);
  }
}
/*/
public void displayLazers(Asteroid asteroid, int j) {
  for (int i = this.lazerList.size(); i > 0; i--){
    Lazer lazer = this.lazerList.get(i-1);
    if (detectCollision(lazer, asteroid, 25)){
    //if (detectCollision(lazer, asteroid, asteroid.getAvgDist())){
      this.asteroidList.remove(j-1);
      this.lazerList.remove(i-1);
      increaseScore(100);
      this.asteroidsDestroyedCounter ++;
      System.out.println(asteroid.getAvgDist());

    }
    lazer.move();
    lazer.show();
    if (lazer.getCenterX() <= 0 || lazer.getCenterX() >= this.screenSizeX ||
      lazer.getCenterY() <= 0 || lazer.getCenterY() >= this.screenSizeY) {
      this.lazerList.remove(i-1);
    }
  }
  
  if (lazerList.size() >= 5) {
        lazerList.remove(0);
  }
}
//*/

//SHIELD METHODS
public void destroyShields() {
  if (this.shieldList.size() > 0) {
    this.shieldList.remove(0);
  }
}

public void displayShield() {
  for (Shield shield : this.shieldList) {
    shield.show();
  }
  if (shieldList.size() > 0) {
    this.spaceship.stopMove();
    this.destroyLazers();  
  }
  maintainShield();
}

public void deployShield() {
  this.shieldList.add(new Shield(this.spaceship));
  this.shieldsRemaining--;
  
}

public void maintainShield(){
  if (this.shieldList.size() > 1) {
    this.shieldList.remove(1);
    this.shieldsRemaining++;
  }
}






public boolean detectCollision(Floater floaterA, Floater floaterB, int distance) {
  return dist( (float)floaterA.getCenterX(),
    (float)floaterA.getCenterY(),
    (float)floaterB.getCenterX(),
    (float)floaterB.getCenterY()
    ) < (float) distance;
}

//TEXT METHODS
public void displayGameMessage(String label) {
  //fill(255, 255, 255);
  //int size = (int)this.textDensity*this.screenArea;
  //textSize(size*2);
  textSize(30); 
  float textPosX = (this.screenSizeX - textWidth(label))/2;
  int textPosY = this.screenSizeY/3;
  text(label, textPosX, textPosY); 
  //text(input, 250, 250); 
}


public void createStat(String label, int input, int rowPos) {
  fill(255, 255, 255);
  textSize(20);
  String string = input + " " + label;
  float textPosX = (this.screenSizeX - textWidth(string))/2;
  float textPosY = (3*this.screenSizeY)/5;

  text(string, textPosX, textPosY + rowPos*25);
}

public void displayStats() {
  //text();
  createStat("asteroids destroyed", this.asteroidsDestroyedCounter, 0);
  createStat("shots fired", this.shotsFiredCounter, 1);
}

public void createDashboard(String label, double input, int rowPos, int sizeAfter) {
  fill(255, 255, 255);
  textSize(15);
  text(label + ": " + nf((float)input, 0, sizeAfter), 20, 20 + rowPos*15);
}

public void displayDashboard() {
  createDashboard("X Position", this.spaceship.getCenterX(), 0, 2) ;
  createDashboard("Y Position", this.spaceship.getCenterY(), 1, 2);
  createDashboard("Direction", this.spaceship.getPointDirection(), 2, 2);
  createDashboard("X Speed", this.spaceship.getXspeed(), 3, 2);
  createDashboard("Y Speed", this.spaceship.getYspeed(), 4, 2);
  createDashboard("High Score", (double) this.highScore, 6, 0);
  createDashboard("Score", (double) this.score, 7, 0);
  createDashboard(" Lives Remaining", (double) this.lives, 9, 0);
  createDashboard("Level", (double) this.level+1, 10, 0);
  createDashboard("Shields Remaining", (double) this.shieldsRemaining, 11, 0);
}

public void setup() {
  //size(500, 500);
  size(1024, 768);
  
  this.screenSizeX = width;
  this.screenSizeY = height;
  this.screenArea = this.screenSizeX*this.screenSizeY;
  

  this.numofStars = (int)(this.screenArea*this.starDensity);
  this.numofAsteroids = (int)(this.screenArea*this.asteroidDensity);

  this.spaceship = new Spaceship(width, height);
  this.stars = new Star[(this.numofStars)];
  this.gameStatus = "PLAYING";
  
  createStars();
  createAsteroids(0);
}

public void draw() {
  background(0);
  
  displayStars();
  displayLazers();
  displayAsteroids();
  displayShield();
  //displayDashboard();
  this.dashboard = new Dashboard(this.gameStatus, this.screenSizeX, this.screenSizeY, this.screenArea, this.textDensity, this.spaceship, this.score, this.highScore, this.lives, this.level, this.shieldsRemaining, this.asteroidsDestroyedCounter, this.shotsFiredCounter);
  this.dashboard.display();

  this.spaceship.move();
  this.spaceship.show();
  
  isGameOver();
  islevelCleared();
}


public void keyPressed() {
  if (key == 'h') {
    this.spaceship.hyperspace();
    destroyLazers();
  } 
  if (key == 'd' || keyCode == RIGHT) {
    this.spaceship.rotateClockwise();
  }
  if (key == 'a' || keyCode == LEFT) {
    this.spaceship.rotateCounterClockwise();
  }
  if (key == 'w' || keyCode == UP) {
    this.spaceship.accelerate(2.0);
  }
  if (key == 's' || keyCode == DOWN) {
    this.spaceship.accelerate(-2.0);
  }
  if (key == 'x' ) {
    this.spaceship.stopMove();
  }
  
  if (key == RETURN || key == ENTER) {
    if (this.isDead) {
      startGame();
    }
    else if(this.canLevelUp) {
      levelUp();
      this.canLevelUp = false;
    }
  }
  if (key == ' ') {
    this.lazerList.add(new Lazer(this.spaceship));
    this.shotsFiredCounter++;
  }
  if (key == 'c' && this.shieldsRemaining != 0) {
    deployShield();
  }
  
  if (key == 'v' && this.shieldList.size() != 0) {
    destroyShields();
  }

  
  if (key == '1') {
    startGame();
  }
  if (key == '2') {
    destroyAsteroids();
  }
  if (key == '3') {
    instantKill();
  }
  if (key == '0') {
    destroyLazers();
  }
}