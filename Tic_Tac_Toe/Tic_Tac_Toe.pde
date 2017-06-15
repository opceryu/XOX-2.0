float blockSize;
ArrayList <block> blocks = new ArrayList <block>();

int turnOwner, winner, mode, selectionMode, selected;
boolean pressed;
button lineButton, reButton;

void setup(){
  size(800,700);
  frameRate(60);
  orientation(LANDSCAPE);
  blockSize = height / 11;
  turnOwner = 1;
  mode = selectionMode = 1;
  pressed = false;
  winner = 0;
  lineButton = new button(width - (blockSize + ((width - height) - blockSize)/ 2), blockSize + height * 4 / 10, blockSize, blockSize, color(100), "", 1);
  reButton = new button(width - (blockSize + ((width - height) - blockSize)/ 2),  blockSize + height * 5 / 10, blockSize, blockSize, color(100), "R", int(blockSize/2));
  
  for(int i = 0; i < 11; i++){
    for(int j = 0; j < 11; j++){
      blocks.add(new block(i,j));
    }
  }
  for(int i = 0; i < blocks.size(); i = i + 12){
    blocks.get(i).splitedRight = true;
  }
  
  for(int i = 10; i < blocks.size()-1; i = i + 10){
    blocks.get(i).splitedLeft = true;
  }
}

void draw(){
  scale(1);
  background(100);
  lineButton.drawButton();
  reButton.drawButton();
  
  if(lineButton.isButtonPressed()){
    mode = mode * -1;
    selectionMode = 1;
    for(int i = 0; i < blocks.size(); i ++){
      block Tblock = blocks.get(i);
      Tblock.check();
    }
    
    if(mode == -1){
    for(int i = 0; i < blocks.size(); i ++){
      block Tblock = blocks.get(i);
      if(Tblock.empty){
        Tblock.c = color(0,255,0);
      }
      else{
        Tblock.c = color(255,0,0);
      }
    }
  }
    
  else if (mode == 1){
    for(int i = 0; i < blocks.size(); i ++){
      block Tblock = blocks.get(i);
      Tblock.c = color(255);
      Tblock.rightSiplitable.clear();
      Tblock.leftSiplitable.clear();
    }
  }
  }
  
  if(reButton.isButtonPressed()){
    restart();
  }
  
  
  turnOwnage();
  for(int i = 0; i < blocks.size(); i ++){
    block Tblock = blocks.get(i);
    Tblock.drawBlock();
  }
  
  for(int i = 0; i < blocks.size() - 3; i ++){//verticle win
    block Ablock = blocks.get(i);
    block Bblock = blocks.get(i +1);
    block Cblock = blocks.get(i +2);
    block Dblock = blocks.get(i +3);
    if(Ablock.owner != 0 && Ablock.owner == Bblock.owner && Bblock.owner == Cblock.owner && Cblock.owner == Dblock.owner){
      winner = Ablock.owner;
      strokeWeight(2);
      stroke(255,0,0);
      line(Ablock.gridX + blockSize / 2, Ablock.gridY + blockSize / 2, Dblock.gridX + blockSize / 2, Dblock.gridY + blockSize / 2);
    }
  }
  for(int i = 0; i < blocks.size() - 33; i ++){//horizontal win
    block Ablock = blocks.get(i);
    block Bblock = blocks.get(i +11);
    block Cblock = blocks.get(i +22);
    block Dblock = blocks.get(i +33);
    if(Ablock.owner != 0 && Ablock.owner == Bblock.owner && Bblock.owner == Cblock.owner && Cblock.owner == Dblock.owner){
      winner = Ablock.owner;
      strokeWeight(2);
      stroke(255,0,0);
      line(Ablock.gridX + blockSize / 2, Ablock.gridY + blockSize / 2, Dblock.gridX + blockSize / 2, Dblock.gridY + blockSize / 2);
    }
  }
  for(int i = 0; i < blocks.size() - 30; i ++){//diagonal win 1
    block Ablock = blocks.get(i);
    block Bblock = blocks.get(i +10);
    block Cblock = blocks.get(i +20);
    block Dblock = blocks.get(i +30);
    if(Ablock.owner != 0 && Ablock.owner == Bblock.owner && Bblock.owner == Cblock.owner && Cblock.owner == Dblock.owner){
      winner = Ablock.owner;
      strokeWeight(2);
      stroke(255,0,0);
      line(Ablock.gridX + blockSize / 2, Ablock.gridY + blockSize / 2, Dblock.gridX + blockSize / 2, Dblock.gridY + blockSize / 2);
    }
  }
  for(int i = 0; i < blocks.size() - 36; i ++){//diagonal win 2
    block Ablock = blocks.get(i);
    block Bblock = blocks.get(i +12);
    block Cblock = blocks.get(i +24);
    block Dblock = blocks.get(i +36);
    if(Ablock.owner != 0 && Ablock.owner == Bblock.owner && Bblock.owner == Cblock.owner && Cblock.owner == Dblock.owner){
      winner = Ablock.owner;
      strokeWeight(2);
      stroke(255,0,0);
      line(Ablock.gridX + blockSize / 2, Ablock.gridY + blockSize / 2, Dblock.gridX + blockSize / 2, Dblock.gridY + blockSize / 2);
    }
  }
}

void mouseReleased(){
  pressed = false;
}

void turnOwnage(){
  fill(100);
  float cent = ((width - height) - blockSize)/ 2;
  strokeWeight(2);
  stroke(255, 255, 0);
  if(turnOwner  == 1){
    rect(width - (blockSize + cent), height / 10, blockSize, blockSize, 3);
  }
  else if(turnOwner == -1){
    rect(width - (blockSize + cent), blockSize + height * 2 / 10, blockSize, blockSize, 3);
  }
  stroke(0);
  drawX(width - (blockSize + cent), height / 10);
  drawO(width - (blockSize + cent), blockSize + height * 2 / 10);
  line(width - (blockSize + cent) + blockSize/10, blockSize + blockSize/10 + height * 4 / 10,
  width - (blockSize + cent) + blockSize * 9/10, blockSize + height * 4 / 10 + blockSize * 9/10);
}

void drawX(float posX, float posY) {
  strokeWeight(3);
  line(posX + blockSize/10, posY + blockSize/10, posX + blockSize/10 * 9, posY + blockSize/10 * 9);
  line(posX + blockSize/10 * 9, posY + blockSize/10, posX + blockSize/10, posY + blockSize/10 * 9);
}

void drawO(float posX, float posY) {
  strokeWeight(3);
  ellipse(posX + blockSize / 2, posY + blockSize / 2, blockSize/10 * 8, blockSize/10 * 8);
}

void drawSymbol(float X, float Y, int Owner){
  stroke(0);
  if(Owner == 1){
    drawX(X,Y);
  }
  if(Owner == -1){
    drawO(X,Y);
  }
}

void restart(){
  for(int i = 0; i < blocks.size(); i++){
    block Tblock;
    Tblock = blocks.get(i);
    Tblock.owner = Tblock.middleOwner= Tblock.topRightOwner= Tblock.topLeftOwner= Tblock.bottomRightOwner= Tblock.bottomLeftOwner= 
    Tblock.topOwner= Tblock.rightOwner = Tblock.leftOwner = Tblock.bottomOwner = 0;
    Tblock.claimed = Tblock.splitedRight= Tblock.splitedLeft = Tblock.middleOwned = Tblock.topRightOwned= Tblock.topLeftOwned = 
    Tblock.bottomRightOwned = Tblock.bottomLeftOwned = Tblock.topOwned = Tblock.bottomOwned = Tblock.rightOwned = Tblock.leftOwned = false;
  }
  for(int i = 0; i < blocks.size(); i = i + 12){
    blocks.get(i).splitedRight = true;
  }
  
  for(int i = 10; i < blocks.size()-1; i = i + 10){
    blocks.get(i).splitedLeft = true;
  }
  turnOwner = 1;
}