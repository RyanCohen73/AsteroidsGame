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
ArrayList<Lazer> lazerList = new ArrayList<Lazer>();

 
public void startGame() {
  destroyLazers();
  destroyAsteroids();
  createAsteroids(0);
  this.spaceship.startingPos();
  this.lives = 5;
  this.score = 0;
}

public void loseGame() {
  if (this.lives == 0) {
    startGame();
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
  int numofAsteroid = this.numofAsteroids + input;
  for(int i = 0; i < numofAsteroids; i++){
    asteroidList.add(new Asteroid(this.screenSizeX, this.screenSizeY));
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
    if (
      dist( (float)this.spaceship.getCenterX(),
      (float)this.spaceship.getCenterY(),
      (float)asteroid.getCenterX(),
      (float)asteroid.getCenterY()
      ) < (float) 25){
      this.asteroidList.remove(j-1);
      this.score = 0;
      this.lives -= 1;
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
      if (
        dist( (float)lazer.getCenterX(),
        (float)lazer.getCenterY(),
        (float)asteroid.getCenterX(),
        (float)asteroid.getCenterY()
        ) < (float) 15){
        this.asteroidList.remove(j-1);
        this.lazerList.remove(i-1);
        if (score == highScore){
          this.highScore += 100;
        }
        this.score += 100;
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

//TEXT METHODS

public void createText(String label, double value, int rowPos, int sizeAfter) {
  fill(255, 255, 255);
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
  createText("Lives Remaining", (double) this.lives, 8, 0);
}


/*
public void destroyFloater(ArrayList<Floater> floaterList) {
  for (int i = floaterList.size(); i > 0; i--){
    //Floater floater = floaterList.get(i-1);
    floaterList.remove(i-1);
  }
}
//*/

public void levelUp() {
  destroyLazers();
  createAsteroids(this.level);
  //this.spaceship.startingPos();
  this.spaceship.stopMove();
}



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
  
  loseGame();
  
  
  //for (Asteroid asteroid : this.asteroidList) {
  

}

public void keyPressed() {
  if (key == 'h') {
    this.spaceship.hyperspace();
    destroyLazers();
  } 
  if (key == 'd') {
    this.spaceship.rotateClockwise();
  }
  if (key == 'a') {
    this.spaceship.rotateCounterClockwise();
  }
  if (key == 'w') {
    this.spaceship.accelerate(2.0);
  }
  if (key == 's') {
    this.spaceship.accelerate(-2.0);
  }
  if (key == ' ') {
    this.lazerList.add(new Lazer(this.spaceship));
  }
  if (key == 'x') {
    this.spaceship.stopMove();
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