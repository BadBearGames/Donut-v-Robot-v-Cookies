//Main GameObject class for pretty much any object in game
class GameObject
{
  PVector velocity, acceleration, position;
  float rotation, mass, speed, maxSpeed; //Rotation in degrees
  PImage img; //Main graphic for object
  int radius;
  
  boolean active;
  
  GameObject(String fileName, float mass)
  {
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    rotation = 0f;
    this.mass = mass;
    if (fileName != null)
    {
      this.img = loadImage(fileName);
      this.img.resize((int)mass * 10, (int)mass * 10);
    }
  }
  
  
  //Method:  update()
  void update()
  {
    if (active)
    {
      //acceleration is being affected by forces in applyForce method
      velocity.add(acceleration);
      velocity.limit(maxSpeed);
      position.add(velocity);
      
      checkEdges();
    }
  }
  
  
  //Method:  checkEdges()
  //Checks this GameObject's position to determine if it is near the edge of the window
  //If so, it wraps the object
  void checkEdges() 
  {
    if (position.x > width) 
    {
      position.x = 0;
    } 
    else if (position.x < 0) 
    {
      position.x = width;
    }
    if (position.y > height) 
    {
      position.y = 0;
    }
    else if (position.y < 0)
    {
      position.y = height;
    }
  }


  //Method:  applyForce()
  //Applies an incoming force to this GameObject's acceleration
  //Mass affects the magnitude of the force
  void applyForce(PVector force)
  {    
    acceleration.add(PVector.div(force, mass));
  }
  
  //method:  applyGravity()
  void applyGravity(PVector force)
  {    
    acceleration.add(PVector.div(force, mass));
  }
  
  //method:  CalculateFriction()
  //Apply a static amoutn of friction to this Game Object
  void calculateFriction()
  {
    PVector fric = this.velocity.copy();
    fric.mult(-1);
    fric.normalize();
    fric.mult(0.1);
    acceleration.add(fric);
 }
 
 //Returns whether or not this object is colliding with another
 Boolean isColliding(PVector otherPosition, int otherRadius)
 {
   if (PVector.dist(this.position, otherPosition) < ((this.radius) + (otherRadius)))
   {
     return true;
   }
   return false;
 }

  //Method:  display()
  //Draws this Mover to the window
  void display()
  {
    //ellipse(position.x, position.y, mass * 5, mass * 5);
    if (active)
    {
      pushMatrix();
      translate(position.x, position.y);
      rotate(radians(rotation));
      image(img, 0, 0);
      popMatrix();
      //ellipse(position.x, position.y, radius * 2, radius * 2);
    }
  }
}