class Ball {
  float x, y, b;
  float d = 40;
  float xSpeed = 0;
  float ySpeed = 0;
  color c = color(50,50,50);


  Ball(float x, float y, float xSpeed, float d, float b, color c){
    //create ball
    this.x = x;
    this.y = y;
    this.xSpeed = xSpeed;
    this.d = d;
    this.b = b;
    this.c = c;
  }
    
  void move(){
    //move ball
    this.y += ySpeed;
    this.ySpeed += gravity;
  }
   
  void show(){
    //draw ball
    fill(c);
    ellipse(this.x, this.y, this.d, this.d);
  }
  
  void collide(){
    /* 
    Collision with bottom of screen
    Ball will keep 80% of its vertical speed after bouncing
    Ball will stop bouncing if its vertical speed is low enough
    */
  
    //Hits bottom of screen
    if (this.y >= height - this.d){
  
      //Stops ball when vertical speed < 1
      if (this.ySpeed < 2){
        this.ySpeed = 0;
      }
      
      //ball keeps 80% of its vertical speed and changes direction
      else{   
        this.ySpeed *= -0.8; 
      }
      
      this.y = height - this.d;
    }
  }
}
