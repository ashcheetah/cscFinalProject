//library to import any sounds
import processing.sound. * ;

//declare my vars for jump sound effects
SoundFile marioJump;

//declare my var for background music for how to play
SoundFile gameTime;

//declare my var for open screen music
SoundFile openMusic;

//declare my var for mario jumping on enemy
SoundFile enemyDeath;

//declare my var for when game is playing
SoundFile instructions;

//declare my var for when player and enemy collide & gameover screen
SoundFile deathMusic;

//declare my var for game over screen music
SoundFile gameDone;

//declare my var for second level screen music 
SoundFile gameComplete;

//declaring my vars
Player p1;

//declaring my vars for blocks with image
ArrayList<Platform> platformBlocks;

//declaring my vars for block for loop
ArrayList<Platform> platformList;

//dclaring my vars for restart game blocks
ArrayList<Platform> aPlatformList;

Enemy e1;

ArrayList<Enemy> enemyList;

//declaring vars & there are 2 images for enemy
Animation enemyAnimation;
PImage[] enemyImages = new PImage[2];

//declaring vars & there are 2 images for mario
Animation marioAnimation;
PImage[] marioImages = new PImage[2];

//0 is a start screen when open mario & 1 is game starting
int startScreen = 0;
boolean gameStarted = false;
PImage marioStartScreenImg;

//declare my button vars for start screen "how to play"
Button button1;
PImage howToPlayScreenImag;

//declare my button vars for start screen "play game"
Button button2;

//game over screen image
PImage gameIsOver;

//play game background image
PImage gamePlaying;

//image for jumping blocks
PImage blocks;

//image for win screen
PImage marioWin;

//for timer 
Timer timer;
int currentTime;
int countdownTime;
int maxTime;
String s;

void setup() {
  size (1200, 800);

  //initalize my vars
  marioJump = new SoundFile(this, "mario.mp3");
  gameTime = new SoundFile(this, "gameMusic.wav");
  openMusic = new SoundFile(this, "openingMusic.wav");
  enemyDeath = new SoundFile(this, "killEnemy.wav");
  instructions = new SoundFile(this, "intro.wav");
  deathMusic = new SoundFile(this, "die.wav");
  gameDone = new SoundFile(this, "deathScreenMusic.wav");
  gameComplete = new SoundFile(this, "winner.wav");
  gameComplete.amp(0.5);


  //initalize my player vars
  p1 = new Player(width/2, 700, 50, 50);

  //initalize my array list for images of platform blocks
  platformBlocks = new ArrayList<Platform>();

  platformList = new ArrayList<Platform>();
  
 aPlatformList = new ArrayList<Platform>();

  e1 = new Enemy(width/2, height - 50, 30, 30);
  enemyList = new ArrayList<Enemy>();
  enemyList.add(e1);

  //loop to fill my enemy array and the 2 is the end of the array because 0, 1 images
  for (int index = 0; index < 2; index ++) {
    enemyImages[index] = loadImage("enemy" + index + ".png");
  }

  for (int index = 0; index < 2; index ++) {
    marioImages[index] = loadImage("mario" + index + ".png");
  }

  //image for blocks to jump on
  blocks = loadImage("jumpBlocks.png");
  blocks.resize(blocks.width - 480, blocks.height - 170);

  //name for images, speed, scale
  enemyAnimation = new Animation(enemyImages, 0.2, 0.3);
  marioAnimation = new Animation(marioImages, 0.1, 1);

  rectMode(CENTER);

  //inialize my start screen image
  marioStartScreenImg = loadImage("welcomeScreen.jpg");
  marioStartScreenImg.resize(marioStartScreenImg.width - 166,
    marioStartScreenImg.height - 280 );

  //inialize my button vars "how to play" button
  button1 = new Button(250, 370, 50); //how to play
  howToPlayScreenImag = loadImage("howToPlay.png");

  //iniaalize my button vars "start game"
  button2 = new Button (830, 370, 50);

  //initalizw my game is over image
  gameIsOver = loadImage("gameOver.png");
  gameIsOver.resize(gameIsOver.width * 2, gameIsOver.height * 2);

  //initalize my play game background
  gamePlaying = loadImage("playGameImg.png");
  gamePlaying.resize(gamePlaying.width + 300, gamePlaying.height + 269);
  
  marioWin = loadImage("newLevel.jpeg");
  marioWin.resize(marioWin.width * 2, marioWin.height * 2);
  
  //for timer 
  timer = new Timer(1000);
  s = "";
  currentTime = 0;
  maxTime = 20;
  countdownTime = maxTime;  
}


void draw() {
  background(42);
  //timer stuff 

  //switch statements between states start
  switch(startScreen) {
    //a start screen
  case 0:
  instructions.pause();
   
     gameComplete.pause();
    startScreen();
    if (openMusic.isPlaying() == false) {
      openMusic.play();
    }

    if (button1.isPressed() == true) {
      button1.display();
      resetGame();
      startScreen = 1;
    } else {
      if (button2.isPressed() == true) {
        button2.displayStartGame();
        resetGame();
        startScreen = 2;
      }
    }
    
   
    break;

  case 1:
    howToPlayScreen();
    openMusic.pause();
    if (gameTime.isPlaying() == false) {
      gameTime.play();
    }
    break;

  case 2:
    
    if (!gameStarted) {
      gameDone.pause();
      openMusic.pause();
      gameTime.pause();
      deathMusic.pause(); 
     enemyDeath.pause();
           resetGame();
      gameStarted = true;

 
    }
    playGame();
    if (instructions.isPlaying() == false) {
      instructions.play();
    }
    
  //  if (startScreen == 4 && startScreen == 3){
  //    resetGame();
  //    gameStarted = true;
  //  }
    
    break;

  case 3:
    gameOverScreen();
    openMusic.pause();
    gameTime.pause();
    instructions.pause();
    delay(3000);
    if (gameDone.isPlaying() == false) {
      gameDone.play();
    }

    break;
   
  case 4:
    instructions.pause();
    if (gameComplete.isPlaying() == false) {
      gameComplete.play();
    }
    delay(2000);
    winGame(); 
   // resetGame();

   break;
   
   case 5: 
    if (!gameStarted) {
           resetGame();
      gameStarted = true;

 
    }
    playGame();
    if (instructions.isPlaying() == false) {
      instructions.play();
    }
    
 
 }

}
//first screen that shows up to display starting game
void startScreen() {
  background (5);
  imageMode(CENTER);
  image(marioStartScreenImg, width/2, height/2);
  fill(5);
  textAlign(CENTER);
  textSize(50);
  text("HOW TO PLAY", 280, 400);
  text("START GAME", 850, 400);
}

void howToPlayScreen() {
  imageMode(CENTER);
  image(howToPlayScreenImag, width/2, height/2);
  fill(5);
  textAlign(CENTER);
  textSize(70);
  text("MOVE: WASD KEYS", width/2, 280);
  textSize(55);
  text("press p key to play", width/2, 350);
  textSize(45);
  text("survive for 20 seconds", width/2, 420);
  
}

void gameOverScreen() {
  imageMode(CENTER);
  image(gameIsOver, width/2, height/2);
  fill(255);
  textAlign(CENTER);
  textSize(40);
  text("press r key to play again", width/2, 750);
}


void gameTimer(){
  if(timer.complete() == true){
    if (countdownTime > 0){
      currentTime++;
      countdownTime --;
      timer.start();
  }
    if (countdownTime == 0){
        currentTime = 0;
      startScreen = 4;
    }
    }
      //text for timer 
  fill(255);
  textSize(60);
  textAlign(CENTER);
  //s = "MARIO " + currentTime;
  s = "MARIO " + countdownTime;
  text(s, 1000, 100);
    }
  
  //screen for when player completes start game level 1 and timer gets to 0
  void winGame(){
    imageMode(CENTER);
    image(marioWin, width/2, height/2);
    fill(5);
    textSize(100);
    text("WINNER!", width/2, 300);
    textSize(50);
    text("press c to continue to MENU", 600, 390);
  }

void playGame() {
  imageMode(CENTER);
  image(gamePlaying, width/2, height/2);
  gameTimer();
  p1.display();
  p1.move();
  p1.wallDetect();
  p1.jumping();
  p1.falling();
  p1.topOfJump();
  p1.land();
  p1.fallOfPlatform(platformList);

  //for loop to go through all platforms
  for (Platform aPlatform : platformList) {
    aPlatform.display();
    aPlatform.collide(p1);
  }

  for (Enemy anEnemy : enemyList) {
    anEnemy.display();
    anEnemy.move();
    anEnemy.collide(p1);
    anEnemy.EnemyOnTimer();
  }

  for (Platform thePlatform : platformBlocks) {
    thePlatform.display();
    thePlatform.collide(p1);
  }
}

void resetGame(){
  imageMode(CENTER);
  image(gamePlaying, width/2, height/2);
  //instructions.play();
  timer.reset();
  countdownTime = 21;
  deathMusic.pause(); 
  enemyDeath.pause();
  openMusic.pause();
  gameTime.pause();
  gameDone.pause();
  gameTimer();
  //p1.x = 100;
  //p1.y = 700;
  p1.display();
  p1.move();
  p1.wallDetect();
  p1.jumping();
  p1.falling();
  p1.topOfJump();
  p1.land();
  p1.fallOfPlatform(platformList);
  //for loop to go through all platforms
  for (Platform aPlatform : platformList) {
    aPlatform.display();
    aPlatform.collide(p1);
  }

  for (Enemy anEnemy : enemyList) {
    anEnemy.display();
    anEnemy.move();
    anEnemy.collide(p1);
    anEnemy.EnemyOnTimer();
  }

  for (Platform plats : aPlatformList) {
    plats.display();
    plats.collide(p1);
  }

  //gameStarted = false;
}

void keyPressed() {
  //if on how to play screen then press p the game starts
  if (startScreen == 1 && key == 'p') {
    startScreen = 2;
  }
  //if player and enemy collide game over screen and press r
  //to go back to game playing
  if (startScreen == 3 ) {
    //&& key == 'r'
     if (keyPressed){
                if (key == 'r');
               // resetGame();
               enemyDeath.pause();
   deathMusic.pause(); 
               startScreen = 0;  
   // if (instructions.isPlaying() == false) {
   // instructions.play();
   // }
    //resetGame();
    //startScreen = 2;
  }
  }
  
  if (startScreen == 4){
    // && key == 'c'
     if (key == 'c');
       //  resetGame();
    startScreen = 0;
  }

  if (key == 'a') {
    p1.isMovingLeft = true;
    if(p1.x < 500){
      platformBlocks.remove(new Platform());
    }
  }
  if (key == 'd') {
    if (p1.x < 700) {
         
      p1.isMovingRight = true;
      for (int i = 0; i < 1; i ++) {
    platformBlocks.add(new Platform());
  }
   
    } else {
      
         p1.isMovingRight = false;
        
        
  
      for (Platform aPlatform : platformList) {
        aPlatform.x -= p1.speed;
      }

      for (Enemy anEnemy : enemyList) {
        anEnemy.x -= p1.speed;
      }

      for (Platform thePlatform : platformBlocks) {
        thePlatform.x -= p1.speed;
      }
    }
  }

 
  if (key == 'w' && p1.isJumping == false && p1.isFalling == false) {
    println("test");
    p1.isJumping = true; //start a jump
    p1.highestY = p1.y - p1.jumpHeight;
    //sound with player whenever w key pressed
    marioJump.play();
  }
}


void keyReleased() {
  if (key == 'a') {
    p1.isMovingLeft = false;
  }
  if (key == 'd') {
    p1.isMovingRight = false;
  }
}
