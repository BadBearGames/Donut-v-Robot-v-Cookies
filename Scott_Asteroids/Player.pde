class Player extends GameObject
{
  //Vars
  int playerNumber, score;
  float moveSpeed, shotTimer, respawnTimer;
  
  boolean canShoot;
  
  Player(int playerNumber, String fileName)
  {
    super(fileName, 5f);
    this.playerNumber = playerNumber;

    moveSpeed = 2f;
    maxSpeed = 10f;
    
    radius = 20;
    
    score = 0;
    
    shoot();
  }
   
  void update(float gameSpeed)
  {
    if (active)
    {
      movePlayer();
      
      acceleration.mult(0.6);
    
      super.update();
      
      velocity.mult(0.95);
      
      //Shooting cooldown
      if (shotTimer > 0f)
      {
        shotTimer -= gameSpeed;
      }
      else
      {
        canShoot = true;
      }
      
      //Respawn protection timer
      if (respawnTimer > 0)
      {
        respawnTimer -= gameSpeed;
      }
    }
    else
    {
      spawn();
    }
  }
  
  //Forces a delay between shooting
  void shoot()
  {
    canShoot = false;
    shotTimer = 15f;
  }
  
  //Move the player around using keyboard input + input man
  void movePlayer()
  {
    if (playerNumber == 1)
    {
      if(inputMan.isKeyPressed('A'))
      {
        rotation -= 5f;
      }
      if(inputMan.isKeyPressed('D'))
      {
        rotation += 5f;
      }
      if (inputMan.isKeyPressed('W'))
      {
        applyForce(PVector.fromAngle(radians(rotation - 90f)).mult(moveSpeed));
      }
    }
    else
    {
      if(inputMan.isKeyPressed(37))
      {
        rotation -= 5f;
      }
      if(inputMan.isKeyPressed(39))
      {
        rotation += 5f;
      }
      if (inputMan.isKeyPressed(38))
      {
        applyForce(PVector.fromAngle(radians(rotation - 90f)).mult(moveSpeed));
      }
    }
  }
  
  //Respawns a player at it's spawning point
  void spawn()
  {
    position = new PVector((width / 3) * playerNumber, height / 2);
    velocity = new PVector(0f, 0f);
    acceleration = new PVector(0f, 0f);
    active = true;
    respawnTimer = 100f;
  }
  
  //Override display for sake of the respawn bubble
  void display()
  {
    if (respawnTimer > 0)
    {
      stroke(#FFFFFF);
      fill(255, 255, 255, 0.5);
      ellipse(position.x, position.y, radius * 4, radius * 4);
    }
    super.display();
  }
}