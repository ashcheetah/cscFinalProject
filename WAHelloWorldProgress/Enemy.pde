class Enemy {

  //variables 
  int x; 
  int y;
  int w;
  int h;
  
  boolean enemyAppear;
  
  //time vars for enemy to appear on timer 
  int spawnInterval; 
  int lastSpawnTime;
  
  //hitbox for enemy 
  int left; 
  int right; 
  int top; 
  int bottom;
  float speed;
  
  boolean isMovingLeft;
  boolean isMovingRight;
  
 boolean shouldRemove;
  
  Enemy(int startingX, int startingY, int startingW, int startingH){
    //constructor is the function to tell processing how to make ur class
  //and initalizing vars 
    
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;  
    
    
    enemyAppear = false; 
    
    spawnInterval = 6000;
    lastSpawnTime = millis(); 
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
    shouldRemove = false;
    
    speed = 10;
  }
  
  //functions 
  
    void display(){
    //draw enemy if visible 
    if (enemyAppear){  
    //animating constantly & enemy appears
    enemyAnimation.display(x, y);
    enemyAnimation.isAnimating = true;
    }
    
    // update hitbox
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }
  
    void move(){
      x -= speed;     
    }
   
  void EnemyOnTimer(){
    if (millis() - lastSpawnTime > spawnInterval) {
    x = width;
    y = 700;
    enemyAppear = true;
    lastSpawnTime = millis();
  }
}

  void collide(Player aPlayer){
    
    if( enemyAppear == true &&
        top < aPlayer.bottom && 
        bottom > aPlayer.top &&
        left < aPlayer.right &&
        right > aPlayer.left){
      
          if (aPlayer.isFalling == true){  
            enemyDeath.play();
            
            enemyAppear = false;
            shouldRemove = true;         
          }
          else {
              println("game over");       
              //if enemy and player collide then game over screen shows up 
              //after press r key the game will restart to start game screen
              
              startScreen = 3;
              deathMusic.play();       
                if (keyPressed){
                if (key == 'r');
                resetGame();
               startScreen = 0;         
              }
          }
          
    }   
    
  }
  }
