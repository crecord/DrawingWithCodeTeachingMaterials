// This is a code example for Drawing with Code at the Ellis School! 
// this is a hello world sketch where you can see the basics of how programming in processing works. 


// first we tell it how big we want the canvase to be!
// We are telling it to be 700 pixels wide and 300 pixels high. 
size(700, 300);
// this is where we set up the background color
// it's like mixing paints! 
// The first number (204) is how much red, the second number is how much green, and the third number is how much blue.
background(204, 102, 0);
//this is where we tell it what color to make the text.
// it works the same as backgound - red, green, blue
fill(55, 250, 255);
// we tell it what font we want to use and then how big we want it.
textFont(createFont("SansSerif",98));
// we tell it what we want to write - "Hello World" and where we want it!
// the first number (0) is how far to the left we want it
// the second number (150) is how far down we want it.
text("Hello World!", 0, 150);
