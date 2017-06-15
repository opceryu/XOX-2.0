package processing.test.tic_tac_toe;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Tic_Tac_Toe extends PApplet {

float blockSize;
ArrayList <block> blocks = new ArrayList <block>();
int turnOwner;
boolean pressed;

class block {
  int  posX, posY;
  float gridX, gridY;
  boolean claimed, splitedRight, splitedLeft, topRightOwned, 
  topLeftOwned, bottomRightOwned, bottomLeftOwned, topOwned, 
  rightOwned, leftOwned, bottomOwned;
  int owner, topRightOwner, topLeftOwner, bottomRightOwner,
  bottomLeftOwner, topOwner, rightOwner, leftOwner, bottomOwner;
  
  block(int x, int y){
    posX = x;
    posY = y;
    gridX = posX * blockSize;
    gridY = posY * blockSize;
    splitedRight = splitedLeft = false;
  }
  
  public void drawBlock(){
    strokeWeight(1);
    rect(gridX, gridY, blockSize, blockSize);
    
    if(splitedRight){
      line(gridX, gridY, gridX + blockSize, gridY + blockSize);
    }
    if(splitedLeft){
      line(gridX + blockSize, gridY, gridX, gridY + blockSize);
    }
    
    if(mousePressed == true && claimed == false && pressed == false &&
    mouseX > gridX && mouseX < gridX + blockSize && mouseY > gridY && 
    mouseY < gridY + blockSize ){
      pressed = true;
      if(splitedRight && splitedLeft){
        if((mouseX - gridX) + (mouseY - gridY)*-1 > 0 && (mouseX - gridX) + (mouseY - gridY) < blockSize && topOwned == false){
          topOwner = turnOwner;
          topOwned = true;
          turnOwner = turnOwner * -1;

        }
        else if((mouseX - gridX) + (mouseY - gridY)*-1 < 0 && (mouseX - gridX) + (mouseY - gridY) > blockSize && bottomOwned == false){
          bottomOwner = turnOwner;
          bottomOwned = true;
          turnOwner = turnOwner * -1;
        }
        else if((mouseX - gridX) + (mouseY - gridY)*-1 > 0 && (mouseX - gridX) + (mouseY - gridY) > blockSize && rightOwned == false){
          rightOwner = turnOwner;
          rightOwned = true;
          turnOwner = turnOwner * -1;
        }
        else if((mouseX - gridX) + (mouseY - gridY)*-1 < 0 && (mouseX - gridX) + (mouseY - gridY) < blockSize && leftOwned == false){
          leftOwner = turnOwner;
          leftOwned = true;
          turnOwner = turnOwner * -1;
        }
      }
      
      else if(splitedRight){
        if((mouseX - gridX) + (mouseY - gridY)*-1 > 0 && topRightOwned == false){
          topRightOwner = turnOwner;
          topRightOwned = true;
          turnOwner = turnOwner * -1;
        }
        else if((mouseX - gridX) + (mouseY - gridY)*-1 < 0 && bottomLeftOwned == false){
          bottomLeftOwner = turnOwner;
          bottomLeftOwned = true;
          turnOwner = turnOwner * -1;
        }
      }
      else if(splitedLeft){
        if((mouseX - gridX) + (mouseY - gridY) > blockSize && bottomRightOwned == false){
          bottomRightOwner = turnOwner;
          bottomRightOwned = true;
          turnOwner = turnOwner * -1;
        }
        else if((mouseX - gridX) + (mouseY - gridY) < blockSize && topLeftOwned == false){
          topLeftOwner = turnOwner;
          topLeftOwned = true;
          turnOwner = turnOwner * -1;
        }
      }
      else{
        claimed = true;
        owner = turnOwner;
        turnOwner = turnOwner * -1;
      }
    }
    
    if(claimed){
      drawSymbol(gridX,gridY,owner);
    }
    
    if(bottomLeftOwned){
      pushMatrix();
      scale(0.5f);
      drawSymbol(gridX*2, (gridY + blockSize/2) * 2,bottomLeftOwner);
      popMatrix();
    }
    
    if(topRightOwned){
      pushMatrix();
      scale(0.5f);
      drawSymbol((gridX + blockSize/2) * 2,gridY * 2,topRightOwner);
      popMatrix();
    }
    
    if(topLeftOwned){
      pushMatrix();
      scale(0.5f);
      drawSymbol(gridX * 2,gridY * 2,topLeftOwner);
      popMatrix();
    }
    
    if(bottomRightOwned){
      pushMatrix();
      scale(0.5f);
      drawSymbol((gridX + blockSize/2) * 2,(gridY + blockSize/2) * 2,bottomRightOwner);
      popMatrix();
    }
    
    if(topOwned){
      pushMatrix();
      scale(0.3f);
      drawSymbol((gridX + blockSize / 2) * 10/3 - blockSize / 2,gridY * 10/3 + blockSize / 10,topOwner);
      popMatrix();
    }
    
    if(bottomOwned){
      pushMatrix();
      scale(0.3f);
      drawSymbol((gridX + blockSize / 2) * 10/3 - blockSize / 2,(gridY + blockSize) * 10/3 - blockSize * 11 / 10,bottomOwner);
      popMatrix();
    }
    
    if(leftOwned){
      pushMatrix();
      scale(0.3f);
      drawSymbol(gridX * 10/3 + blockSize / 10,(gridY + blockSize / 2) * 10/3 - blockSize / 2,leftOwner);
      popMatrix();
    }
    
    if(rightOwned){
      pushMatrix();
      scale(0.3f);
      drawSymbol((gridX + blockSize) * 10/3 - blockSize * 11 / 10,(gridY + blockSize / 2) * 10/3 - blockSize / 2,rightOwner);
      popMatrix();
    }
  }
}


public void setup(){
  
  frameRate(60);
  orientation(LANDSCAPE);
  blockSize = height / 11;
  turnOwner = 1;
  pressed = false;
  
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

public void draw(){
  scale(1);
  background(100);
  for(int i = 0; i < blocks.size(); i ++){
    block Tblock = blocks.get(i);
    Tblock.drawBlock();
  }
}

public void mouseReleased(){
  pressed = false;
}

public void drawX(float posX, float posY) {
  strokeWeight(3);
  line(posX + blockSize/10, posY + blockSize/10, posX + blockSize/10 * 9, posY + blockSize/10 * 9);
  line(posX + blockSize/10 * 9, posY + blockSize/10, posX + blockSize/10, posY + blockSize/10 * 9);
}

public void drawO(float posX, float posY) {
  strokeWeight(3);
  ellipse(posX + blockSize / 2, posY + blockSize / 2, blockSize/10 * 8, blockSize/10 * 8);
}

public void drawSymbol(float X, float Y, int Owner){
  if(Owner == 1){
    drawX(X,Y);
  }
  if(Owner == -1){
    drawO(X,Y);
  }
}
  public void settings() {  size(800,704); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Tic_Tac_Toe" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
