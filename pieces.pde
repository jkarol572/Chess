class Piece {
  String team;
  String rank;
  int id;
  int pos;
  PImage pic;
  boolean active=false;

  Piece(String teamm, String rankk, int idd, int poss, PImage picc) {
    team = teamm;
    rank=rankk;
    id=idd;
    pos=poss;
    pic=picc;
  }
  void draw() {
    imageMode(CENTER);
    if (!active) {
      image(pic, (pos_tox(pos)*90)-45, (pos_toy(pos)*90)-45);
    } else {
      image(pic, mouseX, mouseY);
    }
    imageMode(CORNER);
  }
}