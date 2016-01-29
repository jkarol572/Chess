PImage light, dark, pawnbPic, pawnwPic, queenbPic, queenwPic, rookbPic, rookwPic, knightbPic, knightwPic, kingbPic, kingwPic, bishopbPic, bishopwPic;
ArrayList<Piece> pieces;
int pos;
int active;
int whichblock;
boolean locked;


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
  int xpos = round((mouseX/90)-.5)+1;
  int ypos = round((mouseY/90)-.5);


  return xpos+8*ypos;
}

void setup() {
  size(1300, 720);
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
  bishopwPic=loadImage("bishopw.png");

  //Create piece objects

  pieces.add(new Piece("black", "rook", 1, 1, rookbPic));
  pieces.add(new Piece("black", "knight", 2, 2, knightbPic));
  pieces.add(new Piece("black", "bishop", 3, 3, bishopbPic));
  pieces.add(new Piece("black", "queen", 4, 4, queenbPic));
  pieces.add(new Piece("black", "king", 5, 5, kingbPic));
  pieces.add(new Piece("black", "bishop", 6, 6, bishopbPic));
  pieces.add(new Piece("black", "knight", 7, 7, knightbPic));
  pieces.add(new Piece("black", "rook", 8, 8, rookbPic));

  for (int i = 9; i<17; i++) {
    pieces.add(new Piece("black", "pawn", i, i, pawnbPic));
  }

  pieces.add(new Piece("white", "rook", 17, 64, rookwPic));
  pieces.add(new Piece("white", "knight", 18, 63, knightwPic));
  pieces.add(new Piece("white", "bishop", 19, 62, bishopwPic));
  pieces.add(new Piece("white", "queen", 20, 60, queenwPic));
  pieces.add(new Piece("white", "king", 21, 61, kingwPic));
  pieces.add(new Piece("white", "bishop", 22, 59, bishopwPic));
  pieces.add(new Piece("white", "knight", 23, 58, knightwPic));
  pieces.add(new Piece("white", "rook", 24, 57, rookwPic));

  for (int i = 49; i<57; i++) {
    pieces.add(new Piece("white", "pawn", i-24, i, pawnwPic));
  }
}
void draw() {
  background(255);
  noStroke();
  //Draw board

  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if ((i+j)%2==0) {
        image(light, i*90, j*90);
      } else {
        image(dark, i*90, j*90);
      }
    }
  }

  //Draw Pieces
  for (int i = 0; i<32; i++) {
    pieces.get(i).draw();
  }

  pieces.get(0).draw();




  //Draw Graveyard
  fill(220, 242, 250);
  rect(720, 0, 1300, 720);
}
void keyPressed() {
}
void mousePressed() {
  locked=true;
  for (int i = 0; i<32; i++) {
    if (mouse_toid()==pieces.get(i).pos) {
      whichblock=i;
      println(pieces.get(whichblock).team + " : " +pieces.get(whichblock).rank);
    }
  }
   if (locked && whichblock!=999) {
    pieces.get(whichblock).active=true;
  }
}

void mouseReleased() {
  locked=false;
  whichblock=999;
    for (int i = 0; i<32; i++) {
      pieces.get(i).active=false;
    }
}