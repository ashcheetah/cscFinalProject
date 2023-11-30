
class Platform {
  
  //variables 
  float x; 
  float y;
  float w; 
  float h;
  
  //hitbox for platform 
  float left; 
  float right; 
  float top; 
  float bottom;
  
  int numPlatforms;
  
  //constructor is the function to tell processing how to make ur class
  //and initalizing vars 
  
  Platform(){  
    //iniatlize vars 
    x = random(100, 1000);
    y = random(100, 600);
    w = 160; 
    h = 20;
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
    numPlatforms = 10;
  }
  
  void display(){
    image(blocks, x, y);
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }
  
  void collide(Player aPlayer){
    if (left < aPlayer.right && 
        right > aPlayer.left &&
        top < aPlayer.bottom && 
        bottom > aPlayer.top){
          
          //stop falling
          aPlayer.isFalling = false;
          
          //jumps right on platform
          aPlayer.y = y - h/2 - aPlayer.h/2;     
        }
   }
}
