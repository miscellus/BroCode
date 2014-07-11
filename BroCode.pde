PFont font;
PGraphics g;

int arrowState = 0;

char[][] code;
char lastChar = 'M';
boolean charChanged = false;

int x = 0, y = 0;

final int 	CHAR_SIZE = 24,
			B_WIDTH = 960,
			B_HEIGHT = 600,
			CX = B_WIDTH/CHAR_SIZE,
			CY = B_HEIGHT/CHAR_SIZE;

String allowedCharacters = "abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWYXZ0123456789!\"#%&/=?`|@£$¥~^*'-_.:,;<>\\";

void setup() {

	size(960, 600);
	background(0);
	frame.setResizable(true);
	noSmooth();


	code = new char[CX][CY];

	for (int i = 0; i < CY; i++)
	for (int j = 0; j < CX; j++) {
		code[j][i] = ("@£${[]}+-_.,;!#¤%&/()=12345678").charAt((int)random(0, 30));
	}

	font = createFont("Droid Sans Mono",CHAR_SIZE-1,true);

	g = createGraphics(B_WIDTH, B_HEIGHT);

	g.beginDraw();
	//g.noSmooth();
	g.noStroke();
	g.textFont(font);
	g.endDraw();
	
}

void draw() {

	g.beginDraw();
	g.background(charChanged?0xff250020:0xff0022aa);
	// Display everything
	g.fill(0xff);

	for (int i = 0; i < CY; i++)
	for (int j = 0; j < CX; j++) {
		g.text(code[j][i], j*CHAR_SIZE + 3, CHAR_SIZE + i*CHAR_SIZE - 3);
	}

	g.endDraw();

	// Letter- / Pillarboxing
	if ((float)width/(float)height > 1.6){
		float newWidth = height*1.6;
		image(g, width/2 - newWidth/2, 0, newWidth, height);
	} else {
		float newHeight = width/1.6;
		image(g, 0, height/2 - newHeight/2, width, newHeight);
	}

	
}

void keyPressed() {
	if (key == CODED) {
		switch (keyCode) {
		case LEFT: 	arrowState |= Arrows.LEFT; break;
		case RIGHT: arrowState |= Arrows.RIGHT; break;
		case UP: 	arrowState |= Arrows.UP; break;
		case DOWN: 	arrowState |= Arrows.DOWN; break;
		}
	}
	if (allowedCharacters.indexOf(key) != -1) {
		if (charChanged = (lastChar != key)) {
			lastChar = key;
		}
	}
}

void keyReleased() {
	if (key == CODED) switch (keyCode) {
	case LEFT: 	arrowState ^= Arrows.LEFT; break;
	case RIGHT: arrowState ^= Arrows.RIGHT; break;
	case UP: 	arrowState ^= Arrows.UP; break;
	case DOWN: 	arrowState ^= Arrows.DOWN; break;
	}
}
