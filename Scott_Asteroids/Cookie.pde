class Cookie extends GameObject
{
  
  Cookie(PVector position, float mass)
  {
    super("cookie.png", mass);
    
    if (position == null)
    {
      this.position = new PVector(random(0, width), random(0, height));
    }
    else
    {
      this.position = position;
    }
    
    active = true;
    
    this.rotation = random(0, 360f);
      
    applyForce(PVector.fromAngle(radians(rotation - 90f)).mult(10f));
      
    maxSpeed = (5f / (int)mass) * 1f;
      
    radius = (int)(mass/2) * 10;
  }
  
  void breakUp()
  {
    mass -= 5;
    
    if (mass > 5)
    {
      this.img.resize((int)mass * 10, (int)mass * 10);
      
      this.rotation = random(0, 360f);
      
      applyForce(PVector.fromAngle(radians(rotation - 90f)).mult(10f));
      
      maxSpeed = (5 / (mass) * 5);
      
      radius = (int)(mass/2) * 10;
    }
    else
    {
      active = false;
    }
  }
  
  void update()
  {
    super.update();
  }
}