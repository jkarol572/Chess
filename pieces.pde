class Piece {
  String team;
  String rank;
  int id;
  int pos;
  PImage pic;
  boolean active=false;
  IntList possiblemoves = new IntList();
  IntList tempmoves = new IntList();

  int x;
  int y;
  boolean dead=false;

  Piece(String teamm, String rankk, int idd, int poss, PImage picc) {
    team = teamm;
    rank=rankk;
    id=idd;
    pos=poss;
    pic=picc;
  }
  void draw() {
    if (!dead) {
      this.x=pos_tox(this.pos);
      this.y=pos_toy(this.pos);

      imageMode(CENTER);
      if (!active) {
        image(pic, (pos_tox(pos)*90)-45, (pos_toy(pos)*90)-45);
      } else {
        image(pic, mouseX, mouseY);
      }
      imageMode(CORNER);
    } else {
      this.pos=999;
    }
  }

  void findmoves() {
    tempmoves.clear();
    possiblemoves.clear();


    if (this.rank=="pawn") {
      if (this.team=="white") {
        if (this.y!=1) {
          boolean blocked=false;
          boolean openingblocked=false;
          for (int i=0; i<pieces.size(); i++) {
            if (pieces.get(i).pos==xy_topos(this.x, this.y-1)) {
              blocked=true;
            }
            if (pieces.get(i).pos==xy_topos(this.x, this.y-2) || this.y!=7) {
              openingblocked=true;
            }
          }
          for (int i=0; i<pieces.size(); i++) {
            if (pieces.get(i).pos==xy_topos(this.x+1, this.y-1) && this.x!=8 && pieces.get(i).team=="black") {
              tempmoves.append(xy_topos(this.x+1, this.y-1));
            }
            if (pieces.get(i).pos==xy_topos(this.x-1, this.y-1) && this.x!=1 && pieces.get(i).team=="black") {
              tempmoves.append(xy_topos(this.x-1, this.y-1));
            }

            if (!blocked) {
              tempmoves.append(xy_topos(this.x, this.y-1));
            }
            if (!openingblocked) {
              tempmoves.append(xy_topos(this.x, this.y-2));
            }
          }
        }
      } else {


        if (this.y!=8) {
          boolean blocked=false;
          boolean openingblocked=false;

          for (int i=0; i<pieces.size(); i++) {
            if (pieces.get(i).pos==xy_topos(this.x, this.y+1)) {
              blocked=true;
            }
            if (pieces.get(i).pos==xy_topos(this.x, this.y+2) || this.y!=2) {
              openingblocked=true;
            }
          }
          for (int i=0; i<pieces.size(); i++) {
            if (pieces.get(i).pos==xy_topos(this.x+1, this.y+1) && this.x!=8 && pieces.get(i).team=="white") {
              tempmoves.append(xy_topos(this.x+1, this.y+1));
            }
            if (pieces.get(i).pos==xy_topos(this.x-1, this.y+1) && this.x!=1 && pieces.get(i).team=="white") {
              tempmoves.append(xy_topos(this.x-1, this.y+1));
            }

            if (!blocked) {
              tempmoves.append(xy_topos(this.x, this.y+1));
            }
            if (!openingblocked) {
              tempmoves.append(xy_topos(this.x, this.y+2));
            }
          }
        }
      }
    }
    if(this.rank=="knight"){
      if(this.y<7){}
    
    }

    //Refine the list
    if (tempmoves.size()!=0) {
      possiblemoves.append(tempmoves.get(0));
    }
    for (int i=0; i<tempmoves.size(); i++) {
      boolean repeat=false;
      for (int j=0; j<possiblemoves.size(); j++) {
        if (tempmoves.get(i)==possiblemoves.get(j)) {
          repeat=true;
        }
      }
      if (!repeat) {
        possiblemoves.append(tempmoves.get(i));
      }
    }
  }
}