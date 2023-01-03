//for 100% - each ball changes to a different color when a ball hits a square obstacle - balls shrink when pink square is hit and grow when green square is hit

ArrayList<Ball> balls = new ArrayList<Ball>();

Ball ball;
Block obstacle1, obstacle2;

boolean left = false;
boolean right = false;
boolean space = false;

float newBallX = 0;
float gravity = 0.2;  

void setup() {
  
  size(800, 600);
  ellipseMode(CORNER);
  balls.add(new Ball(100,100, 0, 40, 40, color(50,50,50)));
  
  obstacle1 = new Block();
  obstacle1.w = 100;
  obstacle1.h = 100;
  obstacle1.x = 350;
  obstacle1.y = 200;
  
  obstacle2 = new Block();
  obstacle2.w = 100;
  obstacle2.h = 100;
  obstacle2.x = 350;
  obstacle2.y = 500;
  
}

void draw() {
  
  background(255);
  
  fill(#FF17FC);
  obstacle1.drawBlock();
  fill(#7EFF17);
  obstacle2.drawBlock();
  
  horizontalMove();
  
  windowCollision();
  
  triangle(0, 600, 100, 550, 150, 600);
  
  for (Ball ball: balls){
    topWindowCollision();
    portalCollision();
    blockCollision1();
    blockCollision2();
    ball.move();
    ball.collide();
    ball.show();
  }
}

void mousePressed(){
  int counter = 0;
  
  for (int i = 0; i < balls.size(); i++){
    Ball ball = balls.get(i);
    
    if (mouseX > ball.x && mouseX < ball.x + 40 && mouseY > ball.y && mouseY < ball.y + 40){
      counter = 1;
      balls.remove(ball);
    }
  }
  
  if (counter == 0 && mouseX < 350 || counter == 0 && mouseX > 450 || counter == 0 && mouseY < 500 || counter == 0 && mouseY > 300 || counter == 0 && mouseY < 200){
    balls.add(new Ball(mouseX, mouseY, 9, 40, 40, color(50,50,50)));
  }
} 

void keyPressed(){
  if (key == CODED) {
    
    if (keyCode == LEFT) {
      left = true;
      right = false;
      
      for (Ball ball: balls){
        ball.xSpeed = -9;
      }
    }
      
    if (keyCode == RIGHT) {
      right = true; 
      left = false;
      
      for (Ball ball: balls){
        ball.xSpeed = 9;
      }
    }
  }
  if (keyCode == 32) {
      for (Ball ball: balls) {
        ball.xSpeed = 0;
      }
  }
}

void horizontalMove(){
    if (left == true){
      for (Ball ball: balls){
      ball.x += ball.xSpeed;
      }
    }
    if (right == true){
      for (Ball ball: balls){
        ball.x += ball.xSpeed;
      }
    }
  }

void windowCollision(){
  for (Ball ball: balls){
    if (ball.x <= 0){
      ball.xSpeed *= -1;
    }
    if (ball.x >= 760){
      ball.xSpeed *= -1;
    }
  }
}

void topWindowCollision() {
  for (Ball ball:balls){  
    if (ball.y <= 0){
        ball.ySpeed = 9;
    }
  }
}

void portalCollision(){
  for (Ball ball:balls){
    if (ball.x >= 0 && ball.x <= 40 && ball.y >= 560 || ball.x >= 40 && ball.x <= 110 && ball.y >= 520 || ball.x >= 110 && ball.x <= 150 && ball.y >= 560){
      newBallX = random(0, 760);
      ball.x = newBallX;
      ball.y = 1;
      ball.ySpeed = 9;
    }
    
    if (ball.d == 50){
      if (ball.x >= 0 && ball.x <= 60 && ball.y >= 520 || ball.x >= 90 && ball.x <= 130 && ball.y >= 520){
        newBallX = random(0, 760);
        ball.x = newBallX;
        ball.y = 1;
        ball.ySpeed = 9;
      }
    }
  }
}

String collideElipRectLocation (float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
    if (x1 <= x2+w2 && x1+w1 >= x2 && y1 <= y2+h2 && y1+h1 >= y2) {
        float collisionLeft = x2 + w2 - x1;
        float collisionRight = x1 + w1 - x2;
        float collisionTop = y2 + h2 - y1;
        float collisionBottom = y1 + h1 - y2;
        if (collisionLeft <= collisionBottom && collisionLeft <= collisionTop && collisionLeft <= collisionRight)
            return "left"; 
        else if (collisionRight <= collisionBottom && collisionRight <= collisionTop && collisionRight <= collisionLeft)
            return "right" ;
        else if (collisionTop <= collisionBottom && collisionTop <= collisionLeft && collisionTop <= collisionRight)
            return "top" ;
        else if (collisionBottom <= collisionTop && collisionBottom <= collisionLeft && collisionBottom <= collisionRight) 
            return "bottom" ;
    }

    return "none";
}

void blockCollision1() {
  for (int i = 0; i < balls.size(); i++){
    Ball ball = balls.get(i);
    String collisionResult = collideElipRectLocation(ball.x, ball.y, ball.d, ball.d, obstacle1.x, obstacle1.y, obstacle1.w, obstacle1.h);
    
    if (collisionResult != "none") {
      if (collisionResult == "left" && ball.xSpeed == -9)
        changeRad1Pink(i);
      else if (collisionResult == "right" && ball.xSpeed == 9)
        changeRad2Pink(i);
      else if (collisionResult == "top"){
        changeRadPink(i);
      } else {
        changeRad3Pink(i);
      }
    }
  }
}

void blockCollision2() {
  for (int i = 0; i < balls.size(); i++){
    Ball ball = balls.get(i);
    String collisionResult = collideElipRectLocation(ball.x, ball.y, ball.d, ball.d, obstacle2.x, obstacle2.y, obstacle2.w, obstacle2.h);
    
    if (collisionResult != "none") {
      if (collisionResult == "left" && ball.xSpeed == -9)
        changeRad1Green(i);
      else if (collisionResult == "right" && ball.xSpeed == 9)
        changeRad2Green(i);
      else if (collisionResult == "top")
        changeRadGreen(i);
      else
        changeRad3Green(i);
    }
  }
}   

void changeRadPink(int i){
  Ball ball = balls.get(i);
  ball.c = color(random(0, 256), random(0, 256), random(0, 256));
  ball.d = 20;
  ball.ySpeed = 9;
}

void changeRad1Pink(int i){
  Ball ball = balls.get(i);
  ball.c = color(random(0, 256), random(0, 256), random(0, 256));
  ball.d = 20;
  ball.xSpeed = 9;
}

void changeRad2Pink(int i){
  Ball ball = balls.get(i);
  ball.c = color(random(0, 256), random(0, 256), random(0, 256));
  ball.d = 20;
  ball.xSpeed = -9;
}

void changeRad3Pink(int i){
  Ball ball = balls.get(i);
  ball.c = color(random(0, 256), random(0, 256), random(0, 256));
  ball.d = 20;
  ball.ySpeed = -9;
}

void changeRadGreen(int i){
  Ball ball = balls.get(i);
  ball.c = color(random(0, 256), random(0, 256), random(0, 256));
  ball.d = 50;
  ball.ySpeed = 9;
}

void changeRad1Green(int i){
  Ball ball = balls.get(i);
  ball.c = color(random(0, 256), random(0, 256), random(0, 256));
  ball.d = 50;
  ball.xSpeed = 9;
}

void changeRad2Green(int i){
  Ball ball = balls.get(i);
  ball.c = color(random(0, 256), random(0, 256), random(0, 256));
  ball.d = 50;
  ball.xSpeed = -9;
}

void changeRad3Green(int i){
  Ball ball = balls.get(i);
  ball.c = color(random(0, 256), random(0, 256), random(0, 256));
  ball.d = 50;
  ball.ySpeed = -9;
}
