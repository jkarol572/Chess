class Piece {
  String team;
  String rank;
  int id;
  int pos;
  PImage pic;

  Piece(String teamm, String rankk, int idd, int poss, PImage picc) {
    team = teamm;
    rank=rankk;
    id=idd;
    pos=poss;
    pic=picc;
  }
  void draw() {
    imageMode(CENTER);
    image(pic, (pos_tox(pos)*100)-50, (pos_toy(pos)*100)-50);
    imageMode(CORNER);
  }
}