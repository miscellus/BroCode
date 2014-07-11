PFont font;
PGraphics g;

Arrows arrowState = Arrows.RIGHT;

char[][] code;
char lastChar = 'M';
boolean charChanged = false;

int x = 0, y = 0, xo = 0, yo = 0;

final int 	CHAR_SIZE = 24,
			B_WIDTH = 960,
			B_HEIGHT = 600,
			CX = B_WIDTH/CHAR_SIZE,
			CY = B_HEIGHT/CHAR_SIZE;

String allowedCharacters = " abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWYXZ0123456789!\"#%&/=?`|@£$¥~^*'-_.:,;<>\\";

void setup() {

	size(960, 600);
	background(0);
	frame.setResizable(true);
	noSmooth();


	code = new char[CX][CY];

	for (int i = 0; i < CY; i++)
	for (int j = 0; j < CX; j++) {
		code[j][i] = '.';
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


	for (int i = 0; i < CY; i++)
	for (int j = 0; j < CX; j++) {
		if (i==y && j==x) {
			g.fill(0xff);
			g.rect((j+xo)*CHAR_SIZE, (i+yo)*CHAR_SIZE, CHAR_SIZE, CHAR_SIZE);
			g.fill(0x00);
		} else {
			g.fill(0xaa);
		}
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
		case LEFT: 	arrowState = Arrows.LEFT; break;
		case RIGHT: arrowState = Arrows.RIGHT; break;
		case UP: 	arrowState = Arrows.UP; break;
		case DOWN: 	arrowState = Arrows.DOWN; break;
		}
	}
	if (allowedCharacters.indexOf(key) != -1) {

		charChanged = (lastChar != key);
		code[x][y] = lastChar = key;

		if (arrowState == Arrows.LEFT) {
			x = max(x-1, 0);
			xo = -1;
			yo = 0;
		}
		else if (arrowState == Arrows.RIGHT) {
			x = min(x+1, CX-1);
			xo = 1;
			yo = 0;
		}
		else if (arrowState == Arrows.UP) {
			y = max(y-1, 0);
			yo = -1;
			xo = 0;
		}
		else if (arrowState == Arrows.DOWN) {
			y = min(y+1, CY-1);
			yo = 1;
			xo = 0;
		}

		
		
	}
}

/*void keyReleased() {
	if (key == CODED) switch (keyCode) {
	case LEFT: 	arrowState ^= Arrows.LEFT; break;
	case RIGHT: arrowState ^= Arrows.RIGHT; break;
	case UP: 	arrowState ^= Arrows.UP; break;
	case DOWN: 	arrowState ^= Arrows.DOWN; break;
	}
}*/
