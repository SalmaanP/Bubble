//boolean count = true;         //not used now
boolean start = true;
int retry = 0;                   //used to activate retry button
int fail=0;                     //to spawn the fail bubbles
int mode = 1;                   //to determine game state
int score=0,highscore=0;
int d=100;                      //variable to set delay in fail
float x1;
float y1;
float x2;
float y2;
float x3;
float y3;
PImage img1;
PImage img2;
void setup()
{
  //size(1500,600);
  background(minute(),second(),hour());
  img1 = loadImage("init.png");
  img2 = loadImage("over.png");
  
  
}

void draw()
{
   smooth();
  fill(random(0,255),random(0,255),random(0,255));
  textSize(20);
  
  if(start == true)
  {
    image(img1,0,0,width,height);
  }
  
  if(retry == 1)
  {
    text("Retry?",10,15);
  }
  text("HighScore:"+highscore,((width/2)-60),15);
  text("Score:"+score,(width-75),15);
  
  
  if(mode == 1)                                      //main state
  {
    background(minute(),second(),hour());
    x1 = random(0,width-50);
    y1 = random(0,height-50);
    x2 = random(0,width-50);
    y2 = random(0,height-50);
    x3 = random(0,width-50);
    y3 = random(0,height-50);
    ellipse(x1,y1,100,100);
    //text("11111111",x1,y1);
    
    if(abs(x2 - x1) < 50)                                 //attempt to stop overlapping of bubbles on one another, not much successful.
      {
        x2=random(10,500);
      }
      
      if(abs(y2 - y1) < 50)
      {
        y2=random(10,470);
      }
      
    ellipse(x2,y2,100,100);
    //text("222222",x2,y2);
    
      if(abs(x3 - x2) < 50)                                 //attempt to stop overlapping of bubbles on one another, not much successful.
      {
        x3=random(10,500);
      }
      
      if(abs(y3 - y2) < 50)
      {
        y3=random(10,470);
      }
      
      if(abs(x3 - x1) < 50)
      {
        x3=random(10,500);
      }
      
      if(abs(y3 - y1) < 50)
      {
        y3=random(10,470);
      }
      
    ellipse(x3,y3,100,100);
    //text("3333333",x3,y3);
    mode = 0;                                    //to see it runs only once
  }
  if(fail == 1)                                  //game over screen, spawns extra bubbles over a delay of d ms.
  {
      pushMatrix();
      textSize(30);
      text("Failed",(width/2)-50,height/2);
      popMatrix();
      d=d-1;                                     //delay increases over time, then resets
      
      if(d==1)
      {
        d=5;
      }
      delay(d);                                 
      float e_size = random(10,100);
      float x=random(10,width);
      float y=random(10,height);
      ellipse(x,y,e_size,e_size);
  }
}

void mousePressed()
{
  if(start == true && mouseX>0)
  {
    start=false;
    mode=1;
  }
  if(mouseX > x1-(50) && mouseX < x1+(50) && mouseY > y1-(50) && mouseY < y1+(50) && fail==0)
  {
    mode = 1;                                   //valid bubble, spwan 3 more
    score++;
  }
  if(mouseX > x2-(50) && mouseX < x2+(50) && mouseY > y2-(50) && mouseY < y2+(50) && fail==0)
  {
    mode = 1;                                   //valid bubble, spawn 3 more
    score++;
  }
  if(mouseX > x3-(50) && mouseX < x3+(50) && mouseY > y3-(50) && mouseY < y3+(50))          //invalid bubble
  {
    background(second(),minute(),hour());
    textSize(30);
    text("Failed",(width/2)-50,height/2);
    if(score>highscore)
    {
      highscore=score;
    }
    image(img2,0,0,width,height);
    score=0;  
    retry = 1;                                //display retry button, and activate it.
    fail = 1;                                 //spawn extra bubbles
  }
  if(retry == 1 && mouseX < 100 && mouseY<100)
  {
    fail=0;                                   //stop extra bubbles.
    retry = 0;                                //deactivate retry button
    mode = 1;                                 //reset game.
    d=100;                                    //reset delay.
  }
}
