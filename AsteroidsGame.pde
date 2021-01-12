Spaceship spaceship = new Spaceship();
Star[] stars = new Star[200];

public void displayText (String label, double value, int rowPos) {
    text(label + ": " + nf((float)value, 0, 2), 20, 20 + rowPos*15);
  }

public void setup (){
  size(500, 500);
  for (int i = 0; i < stars.length; i++){
    stars[i] = new Star();
  }
}
public void draw (){
  background(0);
  for (int i = 0; i < stars.length; i++){
    stars[i].show();
  }
  this.spaceship.move();
  this.spaceship.show();
  
  displayText("X Position", this.spaceship.myCenterX, 0);
  displayText("Y Position", this.spaceship.myCenterY, 1);
  displayText("Direction", this.spaceship.myPointDirection, 2);
  displayText("X Speed", this.spaceship.myXspeed, 3);
  displayText("Y Speed", this.spaceship.myYspeed, 4);
  
}
public void keyPressed() {
 if (key == 'h') {
   this.spaceship.hyperspace();
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
}
