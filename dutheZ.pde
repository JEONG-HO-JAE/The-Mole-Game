import ddf.minim.*;

Minim minim;
AudioPlayer song;
PImage img;
PImage byung;
PImage doodle;
PImage ugly;
int score = 0;
float current = 0;
float endTime = 60000;

float spawnTimer = 0;
float interval = 1000;

int b_x;
int b_y;

boolean gameOver = false;
boolean[] doS = new boolean[12];

void setup()
{ 
  size(1152, 648);
  img = loadImage("do.jpg");
  byung = loadImage("time.png");
  doodle = loadImage("doodle.png");
  ugly = loadImage("ugly.png");
  minim = new Minim(this);
  song = minim.loadFile("Zapagetti.mp3");
  song.play();
  current = millis();
  b_x = 0;
  b_y = 150;//gogo
  for (int i = 0; i < doS.length; i++)
  {
    doS[i] = false;
  }

  spawnTimer = millis();
  // doS[8] = true;
  // doS[4] = true;
}





void draw() {
  background(0);
  image(img, 0, 0, width, height);
  image(byung, b_x, b_y, 80, 40);//byung size
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("score : " + score, width/2, 50);
  drawDo();
  randomSpawn();
  time();
}

void time()
{
  b_x = (int)map(millis(), current, current + endTime, 0, width);
  if (current + endTime < millis())
  {
    gameOver();
  }
}



void gameOver()
{
  gameOver = true;
  fill(#00FF4A);
  textAlign(CENTER);
  textSize(50);
  text("score : " + score + "\nClick to start again", width/2, height/2);
  noLoop();
}

void randomSpawn()
{
  if (spawnTimer + interval < millis())
  {
    for(int i = 0; i < doS.length; i++)
    {
      if(doS[i])
      {
        doS[i] = false;
      }
    }
    for (int i = 0; i < 3; i++) //spawn number
    {
      int temp = (int) random(0, 12);
      doS[temp] = true;
    }
    spawnTimer = millis();
  }
}

void drawDo()
{
  for (int i = 0; i < doS.length; i++)
  {
    int xTemp = 40 + 283 * (i%4);
    int yTemp = 216 + 140 * (i/4);
    if (doS[i])
    {
      image(doodle, xTemp, yTemp- 180, 250, 375);
    } else
    {
      image(ugly, xTemp, yTemp, 250, 150);
    }
  }
}

void mousePressed()
{
  for (int i = doS.length - 1; i >= 0; i--)
  {
    int xTemp = 40 + 283 * (i%4);
    int yTemp = 216 + 140 * (i/4);
    if (mouseX > xTemp&&mouseX < xTemp + 250 && mouseY > yTemp - 100 && mouseY < yTemp + 125)
    {
      if (doS[i])
      {
        doS[i] = false;
        score++;
        break;
      }
    }
  }
  
  if(gameOver)
  {
    reset();
    gameOver = false;
  }
}

void reset()
{
 
  song.rewind();
  song.play();
  current = millis();
  b_x = 0;
  b_y = 150;//gogo
  for (int i = 0; i < doS.length; i++)
  {
    doS[i] = false;
  }

  spawnTimer = millis();
  loop();
}