/**
 * Patterns. 
 * 
 * Move the cursor over the image to draw with a software tool 
 * which responds to the speed of the mouse. 
 */
 
void setup() {
  size(640, 360);
  
}

void draw() {
  fill(255,4);
  rect(0,0,width,height);
  // Call the variableEllipse() method and send it the
  // parameters for the current mouse position
  // and the previous mouse position
  variableEllipse(mouseX, mouseY, pmouseX, pmouseY);
  
}


// The simple method variableEllipse() was created specifically 
// for this program. It calculates the speed of the mouse
// and draws a small ellipse if the mouse is moving slowly
// and draws a large ellipse if the mouse is moving quickly 

void variableEllipse(int x, int y, int px, int py) {
  float speed = abs(x-px) + abs(y-py);
  noStroke();
  fill(0);
  ellipse(x, y, speed, speed);
}



void keyPressed() {
 if (key == 's' ) {
   println ("saving new drawing!");
   save("patternDraw_" +millis()+ ".jpg");
 }
}
