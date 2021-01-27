public int score = 0;
public int highScore = 0;
public int level = 0;
public int lives = 5;
public int screenSizeX, screenSizeY;

public double starDensity = 0.0005;
public double asteroidDensity = 0.00002;
public int numofStars, numofAsteroids;

Spaceship spaceship;
Star[] stars;

ArrayList<Asteroid> asteroidList = new ArrayList<Asteroid>();
ArrayList<Asteroid> extraLifeList = new ArrayList<Asteroid>();

ArrayList<Lazer> lazerList = new ArrayList<Lazer>();

//GAME METHODS 
public void startGame() {
  destroyLazers();
  destroyAsteroids();
  createAsteroids(0);
  this.spaceship.startingPos();
  this.lives = 5;
  this.score = 0;
  this.level = 0;
}

public void loseGame() {
  if (this.lives == 0) {
    startGame();
  }
}

public void increaseScore(int input){
  if (score == highScore){
    this.highScore += input;
  }
  this.score += input;
}

public void levelUp() {
  if (this.asteroidList.size() == 0) {
    this.level ++;
    increaseScore(200);

    destroyLazers();
    createAsteroids(this.level);
    
    //this.spaceship.startingPos();
    this.spaceship.stopMove();
  }
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
  for (int j = this.asteroidList.size(); j > 0; j--) {
    Asteroid asteroid = this.asteroidList.get(j-1);
    if (detectCollision(this.spaceship, asteroid, 25)){
      if (asteroid.getType() == "asteroid") {
        this.asteroidList.remove(j-1);
        this.score = 0;
        this.lives -= 1;
      } 
      else {
        this.asteroidList.remove(j-1);
        this.lives += 1;
      }
    }
    else {
      asteroid.move();
      asteroid.show();
    }
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
  for (int i = this.lazerList.size(); i > 0; i--){
    Lazer lazer = this.lazerList.get(i-1);
    
    for (int j = this.asteroidList.size(); j > 0; j--) {
      Asteroid asteroid = this.asteroidList.get(j-1);
      if (detectCollision(lazer, asteroid, 15)){
        this.asteroidList.remove(j-1);
        this.lazerList.remove(i-1);
        increaseScore(100);
      }
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

public boolean detectCollision(Floater floaterA, Floater floaterB, int distance) {
  return dist( (float)floaterA.getCenterX(),
    (float)floaterA.getCenterY(),
    (float)floaterB.getCenterX(),
    (float)floaterB.getCenterY()
    ) < (float) distance;
}

//TEXT METHODS

public void createText(String label, double value, int rowPos, int sizeAfter) {
  fill(255, 255, 255);
  textSize(15);
  text(label + ": " + nf((float)value, 0, sizeAfter), 20, 20 + rowPos*15);
}

public void displayText() {
  createText("X Position", this.spaceship.getCenterX(), 0, 2) ;
  createText("Y Position", this.spaceship.getCenterY(), 1, 2);
  createText("Direction", this.spaceship.getPointDirection(), 2, 2);
  createText("X Speed", this.spaceship.getXspeed(), 3, 2);
  createText("Y Speed", this.spaceship.getYspeed(), 4, 2);
  createText("High Score", (double) this.highScore, 6, 0);
  createText("Score", (double) this.score, 7, 0);
  createText("Lives Remaining", (double) this.lives, 9, 0);
  createText("Level", (double) this.level+1, 10, 0);
}


/*
public void destroyFloater(ArrayList<Floater> floaterList) {
  for (int i = floaterList.size(); i > 0; i--){
    //Floater floater = floaterList.get(i-1);
    floaterList.remove(i-1);
  }
}
//*/



public void setup() {
  //size(500, 500);
  size(1024, 768);
  int screenArea = width*height;
  
  this.screenSizeX = width;
  this.screenSizeY = height;

  this.numofStars = (int)(screenArea*this.starDensity);
  this.numofAsteroids = (int)(screenArea*this.asteroidDensity);

  this.spaceship = new Spaceship(width, height);
  this.stars = new Star[(this.numofStars)];
  
  createStars();
  createAsteroids(0);
}

public void draw() {
  background(0);
  
  displayStars();
  displayLazers();
  displayAsteroids();
  displayText();

  this.spaceship.move();
  this.spaceship.show();
  
  levelUp();
  loseGame();
  
  
  //for (Asteroid asteroid : this.asteroidList) {
  

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
  if (key == ' ') {
    this.lazerList.add(new Lazer(this.spaceship));
  }
  if (key == '3') {
    destroyLazers();
   //destroyFloater(this.lazerList);
  }
  if (key == '2') {
    destroyAsteroids();
   //destroyFloater(this.asteroidList);
  }
  if (key == '1') {
    startGame();
  }
}