class Bullet extends GameObject
{
  //Vars
  int playerNumber;
  
  Bullet(int playerNumber, PVector position, float rotation)
  {
    super(null, 1);
    
    this.playerNumber = playerNumber;
    
    this.position = position;
    
    applyForce(PVector.fromAngle(radians(rotation - 90f)).mult(10f));
    
    active = true;
    
    maxSpeed = 7f;
    
    radius = 5;
  }
  
  void update()
  {
    super.update();
  }
  
  void checkEdges()
  {
    if (position.x > width || position.x < 0 || position.y > height || position.y < 0)
    {
      active = false;
    }
  }
  
  void display()
  {
    //Override GameObject's display
    if (playerNumber == 2)
    {
      fill(#FF0000);
    }
    else
    {
      fill(#0000FF);
    }
    ellipse(position.x, position.y, radius, radius);
  }
}