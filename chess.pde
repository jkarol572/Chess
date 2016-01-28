PImage light, dark, pawnbPic, pawnwPic, queenbPic, queenwPic, rookbPic, rookwPic, knightbPic, knightwPic, kingbPic, kingwPic, bishopbPic, bishopwPic;
ArrayList<Piece> pieces;
int pos;

int pos_tox(int pos) {
  int xpos = pos%8;
  if (xpos==0) { 
    xpos=8;
  }
  return xpos;
}

int pos_toy(int pos) {
  int ypos = pos/8;
  if (pos%8!=0) {
    return round(ypos+0.5);
  } else {
    return round(ypos+0.5)-1;
  }
}

int mouse_toid() {
  int xpos = round((mouseX/100)-.5)+1;
  int ypos = round((mouseY/100)-.5);


  return xpos+8*ypos;
}

void setup() {
  size(1300, 800);
  pieces = new ArrayList<Piece>();
  pos=1;

  //Floor images
  light=loadImage("light.jpg");
  dark=loadImage("dark.jpg");

  //Load piece images 
  pawnbPic=loadImage("pawnb.png");
  pawnwPic=loadImage("pawnw.png");

  queenbPic=loadImage("queenb.png");
  queenwPic=loadImage("queenw.png");

  rookbPic=loadImage("rookb.png");
  rookwPic=loadImage("rookw.png");

  knightbPic=loadImage("knightb.png");
  knightwPic=loadImage("knightw.png");

  kingbPic=loadImage("kingb.png");
  kingwPic=loadImage("kingw.png");

  bishopbPic=loadImage("bishopb.png");
  bishopbPic=loadImage("bishopw.png");

  //Create piece objects

  pieces.add(new Piece("black", "rook", 1, 1, rookbPic));
}
void draw() {
  background(255);
  noStroke();
  //Draw board

  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if ((i+j)%2==0) {
        image(light, i*100, j*100);
      } else {
        image(dark, i*100, j*100);
      }
    }
  }
  pieces.get(0).pos=pos;
  pieces.get(0).draw();
  //Draw Graveyard
  fill(220, 242, 250);
  rect(800, 0, 1300, 800);
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      println("YO");
      pos++;
    }
  }
}