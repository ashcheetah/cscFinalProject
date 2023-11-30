class Timer {
  
  //vars for timer
  int startTime;
  int interval;
  
  //constructor 
  Timer(int timeInterval){
    interval = timeInterval;
  
  }
  
  //functions 
  void start(){
    startTime = millis();  
  }
  
  void reset(){
    startTime = 0; 
    currentTime = 0;
  }
  
  //is the game completed and how long loop lasts
   boolean complete(){
     int elapsedTime = millis() - startTime;
     if(elapsedTime > interval){
       return true;
     } 
     else{
       return false;
     }  
   }
}
