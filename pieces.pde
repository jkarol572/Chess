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
      this.x=999;
      this.y=999;
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
            if (pieces.get(i).pos==xy_topos(this.x, this.y-2) || this.y!=7 ||pieces.get(i).pos==xy_topos(this.x, this.y-1)) {
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
            if (pieces.get(i).pos==xy_topos(this.x, this.y+2) || this.y!=2 ||pieces.get(i).pos==xy_topos(this.x, this.y+1)) {
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
    if (this.rank=="knight") {
      if (this.y<7) {
        if (this.x>1) {
          if (!friendlyfire(this.team, this.x-1, this.y+2)) {
            tempmoves.append(xy_topos(this.x-1, this.y+2));
          }
        }
        if (this.x<8) {
          if (!friendlyfire(this.team, this.x+1, this.y+2)) {
            tempmoves.append(xy_topos(this.x+1, this.y+2));
          }
        }
      }
      if (this.y>2) {
        if (this.x>1) {
          if (!friendlyfire(this.team, this.x-1, this.y-2)) {
            tempmoves.append(xy_topos(this.x-1, this.y-2));
          }
        }
        if (this.x<8) {
          if (!friendlyfire(this.team, this.x+1, this.y-2)) {
            tempmoves.append(xy_topos(this.x+1, this.y-2));
          }
        }
      }

      if (this.x<7) {
        if (this.y>1) {
          if (!friendlyfire(this.team, this.x+2, this.y-1)) {
            tempmoves.append(xy_topos(this.x+2, this.y-1));
          }
        }
        if (this.y<8) {
          if (!friendlyfire(this.team, this.x+2, this.y+1)) {
            tempmoves.append(xy_topos(this.x+2, this.y+1));
          }
        }
      }
      if (this.x>2) {
        if (this.y>1) {
          if (!friendlyfire(this.team, this.x-2, this.y-1)) {
            tempmoves.append(xy_topos(this.x-2, this.y-1));
          }
        }
        if (this.y<8) {
          if (!friendlyfire(this.team, this.x-2, this.y+1)) {
            tempmoves.append(xy_topos(this.x-2, this.y+1));
          }
        }
      }
    }
    if (this.rank=="king") {
      if (this.y>1) {
        if (this.x<8) {
          if (!friendlyfire(this.team, this.x+1, this.y)) {
            tempmoves.append(xy_topos(this.x+1, this.y));
          }
          if (!friendlyfire(this.team, this.x+1, this.y-1)) {
            tempmoves.append(xy_topos(this.x+1, this.y-1));
          }
        }
        if (this.x>1) {
          if (!friendlyfire(this.team, this.x-1, this.y)) {
            tempmoves.append(xy_topos(this.x-1, this.y));
          }
          if (!friendlyfire(this.team, this.x-1, this.y-1)) {
            tempmoves.append(xy_topos(this.x-1, this.y-1));
          }
        }
        if (!friendlyfire(this.team, this.x, this.y-1)) {
          tempmoves.append(xy_topos(this.x, this.y-1));
        }
      }


      if (this.y<8) {
        if (this.x<8) {
          if (!friendlyfire(this.team, this.x+1, this.y+1)) {
            tempmoves.append(xy_topos(this.x+1, this.y+1));
          }
        }
        if (this.x>1) {
          if (!friendlyfire(this.team, this.x-1, this.y+1)) {
            tempmoves.append(xy_topos(this.x-1, this.y+1));
          }
        }
        if (!friendlyfire(this.team, this.x, this.y+1)) {
          tempmoves.append(xy_topos(this.x, this.y+1));
        }
      }
    }
    if (rank=="bishop" || rank=="queen") {
      //up  right diagnol
      boolean upright=false;
      for (int i = this.x; i<8; i++) {
        if (i>0 && i<9 && !friendlyfire(this.team, i+1, this.y+(i-this.x+1)) && !upright && teamc(i+1, this.y+(i-this.x+1))=="s") {
          tempmoves.append(xy_topos(i+1, this.y+(i-this.x+1)));
        } else if (i>0 && i<9 && this.team!=teamc(i+1, this.y+(i-this.x+1)) && !upright) {
          if ((this.team=="white" && teamc(i+1, this.y+(i-this.x+1))=="black")||(this.team=="black" && teamc(i+1, this.y+(i-this.x+1))=="white")) {
            tempmoves.append(xy_topos(i+1, this.y+(i-this.x+1)));
          }
          upright=true;
        } else {
          upright=true;
        }
      }

      //Down right
      boolean downright=false;
      for (int i = this.x; i<8; i++) {
        if (i>0 && i<9 && !friendlyfire(this.team, i+1, this.y-(i-this.x+1)) && !downright && teamc(i+1, this.y-(i-this.x+1))=="s") {
          tempmoves.append(xy_topos(i+1, this.y-(i-this.x+1)));
        } else if (i>0 && i<9 && this.team!=teamc(i+1, this.y-(i-this.x+1)) && !downright) {
          if ((this.team=="white" && teamc(i+1, this.y-(i-this.x+1))=="black")||(this.team=="black" && teamc(i+1, this.y-(i-this.x+1))=="white")) {
            tempmoves.append(xy_topos(i+1, this.y-(i-this.x+1)));
          }
          downright=true;
        } else {
          downright=true;
        }
      }

      //up  left diagnol
      boolean upleft=false;
      for (int i = this.x; i>1; i--) {
        if (i>0 && i<9 && !friendlyfire(this.team, i-1, this.y+(this.x-i+1)) && !upleft && teamc(i-1, this.y+(this.x-i+1))=="s") {
          tempmoves.append(xy_topos(i-1, this.y+(this.x-i+1)));
        } else if (i>0 && i<9 && this.team!=teamc(i-1, this.y+(this.x-i+1)) && !upleft) {
          if ((this.team=="white" && teamc(i-1, this.y+(this.x-i+1))=="black")||(this.team=="black" && teamc(i-1, this.y+(this.x-i+1))=="white")) {
            tempmoves.append(xy_topos(i-1, this.y+(this.x-i+1)));
          }
          upleft=true;
        } else {
          upleft=true;
        }
      }

      //downleft
      boolean downleft=false;
      for (int i = this.x; i>1; i--) {
        if (i>0 && i<9 && !friendlyfire(this.team, i-1, this.y-(this.x-i+1)) && !downleft && teamc(i-1, this.y-(this.x-i+1))=="s") {
          tempmoves.append(xy_topos(i-1, this.y-(this.x-i+1)));
        } else if (i>0 && i<9 && this.team!=teamc(i-1, this.y-(this.x-i+1)) && !downleft) {
          if ((this.team=="white" && teamc(i-1, this.y-(this.x-i+1))=="black")||(this.team=="black" && teamc(i-1, this.y-(this.x-i+1))=="white")) {
            tempmoves.append(xy_topos(i-1, this.y-(this.x-i+1)));
          }
          downleft=true;
        } else {
          downleft=true;
        }
      }
    }
    if (rank=="rook" || rank=="queen") {
      
      boolean down=false;
      for (int i = this.y; i>1; i--) {
        if (i>0 && i<9 && !friendlyfire(this.team, this.x, i-1) && !down && teamc(this.x, i-1)=="s") {
          tempmoves.append(xy_topos(this.x, i-1));
        } else if (i>0 && i<9 && this.team!=teamc(this.x, i-1) && !down) {
          if ((this.team=="white" && teamc(this.x, i-1)=="black")||(this.team=="black" && teamc(this.x, i-1)=="white")) {
            tempmoves.append(xy_topos(this.x,i-1));
          }
          down=true;
        } else {
          down=true;
        }
      }
      
       boolean up=false;
      for (int i = this.y; i<8; i++) {
        if (i>0 && i<9 && !friendlyfire(this.team, this.x, i+1) && !up && teamc(this.x, i+1)=="s") {
          tempmoves.append(xy_topos(this.x, i+1));
        } else if (i>0 && i<9 && this.team!=teamc(this.x, i+1) && !up) {
          if ((this.team=="white" && teamc(this.x, i+1)=="black")||(this.team=="black" && teamc(this.x, i+1)=="white")) {
            tempmoves.append(xy_topos(this.x,i+1));
          }
          up=true;
        } else {
          up=true;
        }
      }
      
       boolean right=false;
      for (int i = this.x; i<8; i++) {
        if (i>0 && i<9 && !friendlyfire(this.team, i+1, this.y) && !right && teamc(i+1, this.y)=="s") {
          tempmoves.append(xy_topos(i+1, this.y));
        } else if (i>0 && i<9 && this.team!=teamc(i+1, this.y) && !right) {
          if ((this.team=="white" && teamc(i+1, this.y)=="black")||(this.team=="black" && teamc(i+1, this.y)=="white")) {
            tempmoves.append(xy_topos(i+1, this.y));
          }
          right=true;
        } else {
          right=true;
        }
      }
      
        boolean left=false;
      for (int i = this.x; i>1; i--) {
        if (i>0 && i<9 && !friendlyfire(this.team, i-1, this.y) && !left && teamc(i-1, this.y)=="s") {
          tempmoves.append(xy_topos(i-1, this.y));
        } else if (i>0 && i<9 && this.team!=teamc(i-1, this.y) && !left) {
          if ((this.team=="white" && teamc(i-1, this.y)=="black")||(this.team=="black" && teamc(i-1, this.y)=="white")) {
            tempmoves.append(xy_topos(i-1, this.y));
          }
          left=true;
        } else {
          left=true;
        }
      }
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