class block {
  int  posX, posY;
  float gridX, gridY;
  boolean empty, claimed, splitedRight, splitedLeft, middleOwned, topRightOwned, 
  topLeftOwned, bottomRightOwned, bottomLeftOwned, topOwned, 
  rightOwned, leftOwned, bottomOwned;
  int owner, middleOwner, topRightOwner, topLeftOwner, bottomRightOwner,
  bottomLeftOwner, topOwner, rightOwner, leftOwner, bottomOwner, arrayNum;
  color c;
  IntList rightSiplitable;
  IntList leftSiplitable;
  
  block(int x, int y){
    posX = x;
    posY = y;
    gridX = posX * blockSize;
    gridY = posY * blockSize;
    empty = splitedRight = splitedLeft = false;
    c = color(255);
    rightSiplitable = new IntList();
    leftSiplitable = new IntList();
    arrayNum = posX * 11 + posY; 
  }
  
  void drawBlock(){
    strokeWeight(1);
    fill(c);
    stroke(0);
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
      if(mode == 1){
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
        else if(middleOwned == false){
          middleOwned = true;
          middleOwner = turnOwner;
          turnOwner = turnOwner * -1;
        }
      }
      //line mode on
      else if(mode == -1 && empty){ 
        if(selectionMode == 1){
          selectionMode = selectionMode * -1;
          for(int i = 0; i < blocks.size(); i ++){
            block Tblock = blocks.get(i);
            Tblock.c = color(255,0,0);
          }
          blocks.get(arrayNum).c = color(255,255,0);
          for(int i = 0; i < 11; i++){
            int diagonal = arrayNum - i * 10;
            if(diagonal >= 0 && diagonal % 11 > arrayNum % 11){
              if(blocks.get(diagonal).empty == false){
                break;
              }
              blocks.get(diagonal).c = color(0,255,0); 
              leftSiplitable.append(diagonal);
            
              
            }
          }
          for(int i = 0; i < 11; i++){
            int diagonal = arrayNum - i * 12;
            if(diagonal >= 0 && diagonal % 11 < arrayNum % 11){
              if(blocks.get(diagonal).empty == false){
                break;
              }
              blocks.get(diagonal).c = color(0,255,0);
              rightSiplitable.append(diagonal);
  
            }
          }
          for(int i = 0; i < 11; i++){
            int diagonal = arrayNum + i * 12;
            if(diagonal <= blocks.size() && diagonal % 11 > arrayNum % 11){
              if(blocks.get(diagonal).empty == false){
                break;
              }
              blocks.get(diagonal).c = color(0,255,0);
              rightSiplitable.append(diagonal);
            }
          }
          for(int i = 0; i < 11; i++){
            int diagonal = arrayNum + i * 10;
            if(diagonal < blocks.size() && diagonal % 11 < arrayNum % 11){
              if(blocks.get(diagonal).empty == false){
                break;
              }
              blocks.get(diagonal).c = color(0,255,0);
              leftSiplitable.append(diagonal);
            }
          }
        }
        else if(selectionMode == -1){
          selected = arrayNum;
        }
      }
    }
    if(inRight()){
      int rss = rightSiplitable.size();
      int lss = leftSiplitable.size();
      for(int i = 0; i < rss; i++){
        int testB = rightSiplitable.get(i);
        if(testB < arrayNum && testB >= selected && testB <= arrayNum){
          blocks.get(testB).splitedRight = true;
        }
         else if(testB > arrayNum && testB <= selected && testB >= arrayNum){
          blocks.get(testB).splitedRight = true;
        }
      }
      rightSiplitable.clear();
      leftSiplitable.clear();
      
      splitedRight = true;
      turnOwner = turnOwner * -1;
      selectionMode = 1;
      mode = 1;
      selected = -1;
      for(int i = 0; i < blocks.size(); i ++){
         block Tblock = blocks.get(i);
         Tblock.c = color(255);
       }
    }
    else if(inLeft()){
      int rss = rightSiplitable.size();
      int lss = leftSiplitable.size();
      for(int i = 0; i < leftSiplitable.size(); i++){
        int testB = leftSiplitable.get(i);
        if(testB < arrayNum && testB >= selected && testB <= arrayNum){
          blocks.get(testB).splitedLeft = true;
        }
         else if(testB > arrayNum && testB <= selected && testB >= arrayNum){
          blocks.get(testB).splitedLeft = true;
        }
      }
      rightSiplitable.clear();
      leftSiplitable.clear();
      splitedLeft = true;
      turnOwner = turnOwner * -1;
      selectionMode = 1;
      mode = 1;
      selected = -1;
      for(int i = 0; i < blocks.size(); i ++){
         block Tblock = blocks.get(i);
         Tblock.c = color(255);
       }
    }
    
    
    if(splitedRight && splitedLeft){
      if(topOwner+bottomOwner+leftOwner+rightOwner>0){
        owner = 1;
      }
      else if(topOwner+bottomOwner+leftOwner+rightOwner<0){
        owner = -1;
      }
      else{
        owner = 0;
      }
    }
    
    else if(splitedRight){
      if(topRightOwner+bottomLeftOwner>0){
        owner = 1;
      }
      else if(topRightOwner+bottomLeftOwner<0){
        owner = -1;
      }
      else{
        owner = 0;
      }
    }
    
    else if(splitedLeft){
      if(topLeftOwner+bottomRightOwner>0){
        owner = 1;
      }
      else if(topLeftOwner+bottomRightOwner<0){
        owner = -1;
      }
      else{
        owner = 0;
      }
    }
    
    if(middleOwned){
      claimed = true;
      owner = middleOwner;
      drawSymbol(gridX,gridY,middleOwner);
    }
    
    if(bottomLeftOwned){
      pushMatrix();
      scale(0.5);
      drawSymbol(gridX*2, (gridY + blockSize/2) * 2,bottomLeftOwner);
      popMatrix();
    }
    
    if(topRightOwned){
      pushMatrix();
      scale(0.5);
      drawSymbol((gridX + blockSize/2) * 2,gridY * 2,topRightOwner);
      popMatrix();
    }
    
    if(topLeftOwned){
      pushMatrix();
      scale(0.5);
      drawSymbol(gridX * 2,gridY * 2,topLeftOwner);
      popMatrix();
    }
    
    if(bottomRightOwned){
      pushMatrix();
      scale(0.5);
      drawSymbol((gridX + blockSize/2) * 2,(gridY + blockSize/2) * 2,bottomRightOwner);
      popMatrix();
    }
    
    if(topOwned){
      pushMatrix();
      scale(0.3);
      drawSymbol((gridX + blockSize / 2) * 10/3 - blockSize / 2,gridY * 10/3 + blockSize / 10,topOwner);
      popMatrix();
    }
    
    if(bottomOwned){
      pushMatrix();
      scale(0.3);
      drawSymbol((gridX + blockSize / 2) * 10/3 - blockSize / 2,(gridY + blockSize) * 10/3 - blockSize * 11 / 10,bottomOwner);
      popMatrix();
    }
    
    if(leftOwned){
      pushMatrix();
      scale(0.3);
      drawSymbol(gridX * 10/3 + blockSize / 10,(gridY + blockSize / 2) * 10/3 - blockSize / 2,leftOwner);
      popMatrix();
    }
    
    if(rightOwned){
      pushMatrix();
      scale(0.3);
      drawSymbol((gridX + blockSize) * 10/3 - blockSize * 11 / 10,(gridY + blockSize / 2) * 10/3 - blockSize / 2,rightOwner);
      popMatrix();
    }
  }
  void check(){
      if(splitedRight == false && splitedLeft == false){
        if(claimed == false){
          empty = true;
        }
        else{
          empty = false;
        }
      }
      else if(splitedRight == true && splitedLeft == true){
        if(topOwned == false && bottomOwned == false && leftOwned == false && rightOwned == false){
          empty = true;
        }
        else{
          empty = false;
        }
     }
     else if(splitedRight == true){
       if(topRightOwned == false && bottomLeftOwned == false){
         empty = true;
        }
       else{
         empty = false;
       }
    }
     else if(splitedLeft == true){
       if(topLeftOwned == false && bottomRightOwned == false){
         empty = true;
        }
        else{
         empty = false;
      }
    }
  }
  boolean inRight(){
    boolean prob;
    int testB;
    prob = false;
    for(int i = 0; i < rightSiplitable.size(); i++){
      testB = rightSiplitable.get(i);
      if(testB == selected){
        prob = true;
      }
    }
    return prob;
  }
  
  boolean inLeft(){
    boolean prob;
    int testB;
    prob = false;
    for(int i = 0; i < leftSiplitable.size(); i++){
      testB = leftSiplitable.get(i);
      if(testB == selected){
        prob = true;
      }
    }
    return prob;
  }
}