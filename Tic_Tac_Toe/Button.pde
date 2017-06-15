class button {
  float x,y,Dx,Dy,Tsize;
  color c, topc, pressedc;
  boolean lastButton, active;
  String text;
  
  button(float X, float Y, float DX, float DY, color C, String Text, int size){
    c = C;
    x = X;
    y = Y;
    Dx = DX;
    Dy = DY;
    topc = color(red(c) + 40, green(c) + 40, blue(C) + 40);
    pressedc = color(red(c) + 20, green(c) + 20, blue(C) + 20);
    text = Text;
    Tsize = size;
    lastButton = false;
    active = true;
  }
  
  void drawButton() {
    if (isButtonHold()){
      fill(pressedc);
    }
    
    else if (onTheButton()) {
      fill(topc);
    }
    
    else {
      fill(c);
    }
    stroke(0);
    strokeWeight(1);
    rect(x,y,Dx,Dy,5);
    
    
    fill(0);
    textSize(Tsize);
    text(text, x + Dx / 2, y + Dy / 2);
    textAlign(CENTER, CENTER);
  }
  
  boolean onTheButton() {
    if (mouseX > x && mouseY > y && mouseX < x + Dx && mouseY < y + Dy && active) {
      return true;
    }
    else 
    return false;
  }
  
  
  boolean isButtonHold() {
    if (onTheButton() && mousePressed){
      return true;
    }
    else
    return false;
  }

  
  boolean isButtonPressed() {
    boolean result;
    if(isButtonHold() && !lastButton){
      lastButton = true;
      result = true; 
    }
    else{
      result = false;
    }
    if(!isButtonHold() && !mousePressed){
      lastButton = false;
    }
    return result;
  }
}