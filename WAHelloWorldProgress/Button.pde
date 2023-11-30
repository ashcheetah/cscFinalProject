class Button {
//// class vars 
  //position and color of buttons 
  int x;
  int y;
  int size;

//////constructor function 
 Button (int buttonStartingX, int buttonStartingY, int buttonStartingSize){
      //initalize some of my class vars from the paramaters 
      x = buttonStartingX; 
      y = buttonStartingY;
      size = buttonStartingSize;
  }
  
/////////functions 
  
///draws and colors ball
  void display(){
    fill(255);
    textAlign(CENTER);
    textSize(50);
    text("HOW TO PLAY", 280, 400);   
  }
  
  void displayStartGame(){
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("START GAME", 850, 400);    
  }
  
  boolean isBetween(int num, int min, int max) {
  //makes it easier to use our buttons 
  if (num > min && num < max){
    return true;
}
else {
  return false;
}
}

boolean isPressed() {
  
  //bounds of the button 
  if (isBetween(mouseX, x, x + size) && 
  isBetween(mouseY, y, y + size) 
  && mousePressed == true){
  return true;

}
else {
  return false;
}
}


}
