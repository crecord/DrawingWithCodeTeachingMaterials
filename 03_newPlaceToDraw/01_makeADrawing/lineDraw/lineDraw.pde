/**
 * Continuous Lines. 
 * 
 * Click and drag the mouse to draw a line. 
 */

void setup() {
  size(600, 600);
  background(255);
  strokeWeight(10);
}

void draw() {
  stroke(0);
  if (mousePressed == true) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

void keyPressed() {
 if (key == 's' ) {
   println ("saving new drawing!");
   save("continuousLinesDraw" +millis()+ ".jpg");
 }
}
