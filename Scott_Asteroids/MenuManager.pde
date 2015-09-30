class MenuManager
{
  int currentMenu;
  String winText;
  float nextTimer;
  
  MenuManager()
  {
    currentMenu = 1;
  }
  
  void display()
  {
    switch (currentMenu)
    {
      case 1:
      //Start
      
      fill(#FFFFFF);
      textFont(timerFont);
      textAlign(CENTER);
      text("Donut v Robot v Cookies\nin 20 Seconds\nor Less", width / 2, height / 2 - 150);
      text("Press Space to start.", width / 2, 600);
      break;
      
      case 2:
      fill(#FFFFFF);
      textFont(scoreFont);
      textAlign(LEFT);
      text(gameMan.players.get(0).score, 10, 40); 
      textAlign(RIGHT);
      text(gameMan.players.get(1).score, width - 10, 40); 
      
      textFont(timerFont);
      textAlign(CENTER);
      text(round(gameMan.timer), width / 2, 70);
      break;
      
      case 3:
      //Game Over
      if (winText != null)
      {
        fill(#FFFFFF);
      textFont(timerFont);
      textAlign(CENTER);
      text(winText, width / 2, height / 2);
      
      if (nextTimer > 0)
      {
        nextTimer -= 1;
      }
      else
      {
        currentMenu = 1;
      }
      
      }
      break;
    }
  }
}