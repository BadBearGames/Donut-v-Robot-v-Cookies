//contains an array for checking which keys are down
class InputManager 
{
  boolean[] keys;

  InputManager() 
  {
    keys = new boolean[256];
  }

  void recordKeyPress(int k) 
  {
    keys[k] = true;
  }

  void recordKeyRelease(int k) 
  {
    keys[k] = false;
  }

  boolean isKeyPressed(int k) 
  {
    return keys[k];
  }

  boolean isKeyReleased(int k) 
  {
    return !keys[k];
  }
}