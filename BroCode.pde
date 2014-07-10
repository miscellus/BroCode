import java.util.Vector;

PFont font;
String typing, cursor;

PGraphics g;

int rot = 0;

void setup() {
	size(960, 600);
	background(0);
	frame.setResizable(true);

	noSmooth();

	typing = "";

	font = createFont("Nimbus Mono L",16,false);

	g = createGraphics(320, 200);

	g.beginDraw();
	g.noSmooth();
	g.noStroke();
	g.textFont(font);
	g.endDraw();
	
}

void draw() {

	rot = (rot + 1) % 20;

	cursor = rot<11 ? "_" : "";

	g.beginDraw();

	g.background(60);
	// Display everything
	g.fill(0xff);

	g.text(typing+cursor,16,g.height-16);

	g.endDraw();

	if ((float)width/(float)height > 1.6){
		float newWidth = height*1.6;
		image(g, width/2 - newWidth/2, 0, newWidth, height);
	} else {
		float newHeight = width/1.6;
		image(g, 0, height/2 - newHeight/2, width, newHeight);
	}

	
}

void keyPressed() {
  // If the return key is pressed, save the String and clear it
  switch (keyCode) {

  case ENTER:
  	typing = "";
  	break;
  
  case BACKSPACE:
  	if (typing.length() < 1) break;
  	typing = typing.substring(0, typing.length()-1);
  	break;

  default:
  	typing += key;
  }
}
