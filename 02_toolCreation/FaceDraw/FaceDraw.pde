//
// move the "pencil" with your face
// angle your face left, right, up, & down
// press c to clear the screen
// press s to save a jpeg
//
// derived from the FaceOSCReceiver demo

// OSC stands for Open Sound Control it is how we are talking to the face tracking app.
// we need to have the OSC processing library installed!
import oscP5.*;
OscP5 oscP5;

int found; // this will tell us whether we found a face.
PVector poseOrientation; //this will store the orientation of our face. 

void setup() {
  // the size of our paper
  size(600, 400);
  // set the frame rate
  frameRate(30);
  // this is the port we are talking to osc on
  oscP5 = new OscP5(this, 8338);
  // these are the variables we want to know from the face tracker
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  // this initializes the variable that will understand the orientation
  poseOrientation = new PVector();
  //this sets the background to white.
  background(255);
}

void draw() { 
  // this creates the fading effect. Change the second parameter to make it more or less "fadey"  
  fill(255,10);
  rect(0,0,width,height);
  // this if statement asks whether a face is detected.
  if (found > 0) {
    // this fills the circle with a black color
    fill(0);
    // this uses your distance from the screen to set the size of the circle
    float size = map(poseOrientation.z, .2, 0, 20, 30 );
    //set the x position of the circle
    float ellipseX = map(poseOrientation.y, -.5, .5, 0, width);
    //set the y position of the circle
    float ellipseY = map(poseOrientation.x, -.5, .5, 0, height);
    // draw the circle
    ellipse(ellipseX, ellipseY, size, size);
  }
}

void keyPressed() {
  if (key == 's') {
    // save a picture with a unique file name.
    int m = millis();
    save("faceDoodle" + m +".jpg");
 }
 else if (key == 'c'){
   // clear the screen by drawing a white rectangle.
   fill(255);
  rect(0,0,width,height);
 }
}

// this function tells us whether we found a face.
public void found(int i) {
  found = i;
}

// this funtion tells us the oreintation of the face.
public void poseOrientation(float x, float y, float z) {
  println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
  poseOrientation.set(x, y, z);
}



