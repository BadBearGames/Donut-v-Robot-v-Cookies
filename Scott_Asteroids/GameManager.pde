//Contains all gameplay logic
class GameManager
{
  //vars
  ArrayList<Player> players;
  ArrayList<Bullet> bullets;
  ArrayList<Cookie> cookies;
  
  //scoring vars
  float timer, lastTime, startTime;
  
  Boolean isGameOver;
  
  public GameManager()
  {
    this.init();
  }
  
  void init()
  {
    //Init lists
    players = new ArrayList<Player>();
    bullets = new ArrayList<Bullet>();
    cookies = new ArrayList<Cookie>();
    
    isGameOver = true;
  }
  
  void startGame()
  {
    //Spawn players
    Player p = new Player(1, "donut.png");
    players.add(p);
    p.spawn();
    p = new Player(2, "robot.png");
    players.add(p);
    p.spawn();
    
    //Spawn cookies
    for (int i = 15; i >= 0; i--)
    {
      Cookie c = new Cookie(null, random(5, 15));
      cookies.add(c);
    }
    
    timer = 20;
    lastTime = 0;
    isGameOver = false;
    startTime = millis();
  }
  
  //Creates a bullet from a specific player
  void createBullet(int playerNumber)
  {
    Bullet b = new Bullet(playerNumber, players.get(playerNumber - 1).position.copy(), players.get(playerNumber - 1).rotation);
    bullets.add(b);
    players.get(playerNumber - 1).shoot();
  }
  
  //Updates all gameobjects
  void update(float gameSpeed)
  {
    if (!isGameOver)
    {
    for (int i = players.size() - 1; i >= 0; i--)
    {
      players.get(i).update(gameSpeed);
    }
    
    for (int i = cookies.size() - 1; i >= 0; i--)
    {
      cookies.get(i).update();
      
      if (cookies.get(i).active)
      {
        for (int i2 = players.size() - 1; i2 >= 0; i2--)
        {
          if (players.get(i2).active && players.get(i2).respawnTimer <= 0)
          {
            if (cookies.get(i).isColliding(players.get(i2).position, players.get(i2).radius))
            {
              players.get(i2).active = false;
              players.get(i2).score -= 5;
            }
          }
        }
      }
      else
      {
        cookies.remove(i);
      }
    }
    
    //Shoot bullets
    if (inputMan.isKeyPressed(32) && players.get(0).canShoot)
    {
        createBullet(1);
        players.get(0).respawnTimer = 0;
    }
    else if (inputMan.isKeyPressed('M') && players.get(1).canShoot)
    {
        createBullet(2);
        players.get(1).respawnTimer = 0;
    }
    
    for (int i = bullets.size() - 1; i >= 0; i--)
    {
      bullets.get(i).update();
      
      //Test collisions
      if (bullets.get(i).active)
      {
        for (int i2 = cookies.size() - 1; i2 >= 0; i2--)
        {
          if (bullets.get(i).isColliding(cookies.get(i2).position, cookies.get(i2).radius))
          {
            players.get(bullets.get(i).playerNumber - 1).score += 20;
            bullets.get(i).active = false;
            //Breakup cookie
            cookies.get(i2).breakUp();
            //Add another cookie if still active
            if (cookies.get(i2).active)
            {
              Cookie c = new Cookie(cookies.get(i2).position.copy(), cookies.get(i2).mass);
              cookies.add(c);
            }
          }
        }
      }
      
      //Test against player
      if (bullets.get(i).active)
      {
        if (bullets.get(i).playerNumber == 1 && players.get(1).active && players.get(1).respawnTimer <= 0 && bullets.get(i).isColliding(players.get(1).position, players.get(1).radius))
        {
          players.get(1).active = false;
          players.get(0).score += 10;
          bullets.get(i).active = false;
        }
        else if (bullets.get(i).playerNumber == 2 && players.get(0).active && players.get(0).respawnTimer <= 0 && bullets.get(i).isColliding(players.get(0).position, players.get(0).radius))
        {
          players.get(0).active = false;
          players.get(1).score += 10;
          bullets.get(i).active = false;
        }
      }
      
      if (!bullets.get(i).active)
      {
        bullets.remove(i);
      }
    }
    
    
    //Determine when game is over
    if (timer > 0)
    {
      timer = 20 - ((millis() - startTime) / 1000);
      if (timer < 0)
      {
        timer = 0f;
      }
    }
    else if (cookies.size() == 0)
    {
      gameOver();
    }
    else
    {
      timer = 0;
      gameOver();
    }
    
    lastTime = millis();
    }
  }
  
  //All Game Over logic
  void gameOver()
  {
    if (players.size() > 0)
    {
    if (players.get(0).score > players.get(1).score)
    {
      menuMan.winText = "Game Over.\nPlayer 1 wins!";
    }
    else if (players.get(0).score < players.get(1).score)
    {
      menuMan.winText = "Game Over.\nPlayer 2 wins!";
    }
    else
    {
      menuMan.winText = "Tie...";
    }
    
    for (int i = players.size() - 1; i >= 0; i--)
    {
      players.remove(i);
    }
    for (int i = cookies.size() - 1; i >= 0; i--)
    {
      cookies.remove(i);
    }
    for (int i = bullets.size() - 1; i >= 0; i--)
    {
      bullets.remove(i);
    }
    
    isGameOver = true;
    menuMan.nextTimer = 200f;
    menuMan.currentMenu = 3;
    }
  }
  
  //Displays all gameobjects
  void display()
  {
    for (int i = bullets.size() - 1; i >= 0; i--)
    {
      bullets.get(i).display();
    }
    
    for (int i = players.size() - 1; i >= 0; i--)
    {
      players.get(i).display();
    }
    
    for (int i = cookies.size() - 1; i >= 0; i--)
    {
      cookies.get(i).display();
    }
  }
}