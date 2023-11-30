class Player {
  
  //variables 
  float x;
  float y;
  
  float w;
  float h;
  
  //directions of player 
  boolean isMovingLeft;
  boolean isMovingRight;
  
  //jumping player 
  boolean isJumping;
  boolean isFalling;

  int speed;
  
  //distance that you can jump upwards
  int jumpHeight; 
  
  //y value of the top of your jump 
  float highestY;
  
   //hitbox for platform 
  float left; 
  float right; 
  float top; 
  float bottom;
  
  //constructor 
  Player(int startingX, int startingY, int startingW, int startingH){
    //inialize my vars 
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;  
    
    isMovingLeft = false;
    isMovingRight = false;
    
    isJumping = false;
    isFalling = false;
    
    speed = 10;
    
    jumpHeight = 200;
    highestY = y - jumpHeight;
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
  }
  
  //functions 
  void display(){
    marioAnimation.display(x, y);
    marioAnimation.isAnimating = true;  
 }
  
  void move(){
    if (isMovingLeft == true){
      x -= speed; //x = x - speed
    }
    
    if (isMovingRight == true){
      x += speed; //x = x + speed
    }
    
    //updates the bounds of the player 
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }
  
  // detects when the ball hits the edge of the window, and when it does hit
//it should bounce off of it.
  void wallDetect(){
    // detects wall detection for the right wall
    if (x + w/2 >= width) {
       x -= speed;
    }
    // wall detection for left wall
    if (x - w/2 <= 0) {
      x += speed;
    }
  } 


  void jumping(){
    if (isJumping == true){
      y -= speed;     
    }
  }
  
  void falling(){
    if (isFalling == true){
      y += speed;
       
    }
  }
  
  void topOfJump(){
    if (y <= highestY){
      isJumping = false; //stop jumping upward
      isFalling = true;
    }
  }
  
  void land(){
    if (y >= 700){
      isFalling = false; //stop falling 
      y = 700; //snap player to posotion they are standing at the bottom of window
      
    }
  }
  
  //check to see if the player is colliding with any platform 
  //if the player is not colliding with any platforms then 
  //make the player start falling 
  void fallOfPlatform(ArrayList<Platform> aPlatformList){
    
    //check that the player is not in the middle of a jump 
    //and check that the player is not on the ground 
    if (isJumping == false && y < 700){
      
      boolean onPlatform = false;
      
      for (Platform aPlatform : platformList){
        //if the player is colliuding with a platform 
        if (top <= aPlatform.bottom && 
            bottom >= aPlatform.top && 
            left <= aPlatform.right && 
            right >= aPlatform.left){
              //make on platform true
              onPlatform = true;
            }
      }
      
       for (Platform aPlatform : platformBlocks){
        //if the player is colliuding with a platform 
        if (top <= aPlatform.bottom && 
            bottom >= aPlatform.top && 
            left <= aPlatform.right && 
            right >= aPlatform.left){
              //make on platform true
              onPlatform = true;
              println("on platform");
            }
      }
      
      for (Platform plats : aPlatformList) {
        //if the player is colliuding with a platform 
        if (top <= plats.bottom && 
            bottom >= plats.top && 
            left <= plats.right && 
            right >= plats.left){
              //make on platform true
              onPlatform = true;
      }
      } 
         //if you are not on a platform, start falling 
        if (onPlatform == false){
          isFalling = true; 
         
      }  
    } 
  }
}
