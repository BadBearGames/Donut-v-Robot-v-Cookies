//By Nelson Scott
import ddf.minim.*;
Minim minim;
AudioPlayer song;

//Vars
GameManager gameMan;
InputManager inputMan;
MenuManager menuMan;

PImage backgroundImg;
PFont scoreFont, timerFont;

void setup()
{
  size(1050, 650);
  imageMode(CENTER);
  shapeMode(CENTER);
  
  scoreFont = createFont("Arial", 30, true);
  timerFont = createFont("Arial", 80, true);
  
  this.init();
}

void init()
{
  gameMan = new GameManager();
  inputMan = new InputManager();
  menuMan = new MenuManager();
  
  backgroundImg = loadImage("background.png");
  
  minim = new Minim(this);
  song = minim.loadFile("song.mp3");
  song.play();  
}

void keyPressed()
{
  inputMan.recordKeyPress(keyCode);
}

void keyReleased()
{
  inputMan.recordKeyRelease(keyCode);
}

void draw()
{
  if (!song.isPlaying())
  {
    song.rewind();
    song.play();
  }
  
  background(backgroundImg);
  if (!gameMan.isGameOver)
  {
    gameMan.update(1.0f);
    gameMan.display();
  }
  else
  {
    if (inputMan.isKeyPressed(32) && menuMan.currentMenu == 1)
    {
      gameMan.startGame();
      menuMan.currentMenu = 2;
    }
  }
  
  menuMan.display();
}