// UiElement class
// Basic Interface element with basic touch/click/drag functionality
// Coded by Nicolai R. Tellefsen

public class UiElement {
  //Physical dimensions
  protected float x; //X position
  protected float y; //Y position
  protected float z; //Z position
  protected float width; //Current width
  protected float height; //Current height
  
  //Virtual dimensions
  protected int priority = 0; //Current priority (for comparison with other UiElements)
  protected String id;
  
  //Touch dimensions 
  protected boolean touchable = false; //Touch enabled?
  protected boolean dragging = false; //Dragging enabled?
  protected float touchX;
  protected float touchY;
  protected float touchWidth;
  protected float touchHeight;
  
  //Constructor, sets default values
  UiElement(float _x, float _y, float _z, float _width, float _height) {
    this.x = _x;
    this.y = _y;
    this.z = _z;
    this.width = _width;
    this.height = _height;
  }
  
  //Enable touch functionality
  public boolean addTouch(float _touchX, float _touchY, float _touchWidth, float _touchHeight) {
    this.touchX = _touchX;
    this.touchY = _touchY;
    this.touchWidth = _touchWidth;
    this.touchHeight = _touchHeight;
    this.touchable = true; //Touch has been enabled
    
    return true;
  }
  public boolean addTouch() {
    return addTouch(this.x,this.y,this.width,this.height);
  }
  
  //Disable touch functionality
  public boolean removeTouch() {
    this.touchable = false;
    return true;
  }
  
  //Change the size of the touch area
  public boolean changeTouchSize(float _touchWidth, float _touchHeight) {
    this.touchWidth = _touchWidth;
    this.touchHeight = _touchHeight;
    
    return true;
  }
  
  //Change object priority
  public void setPriority(int _priority) {
    this.priority = _priority;
  }
  
  //Get object priority
  public int getPriority() {
    return this.priority;
  }
  
  //Change object id
  public void setId(String _id) {
    this.id = _id;
  }
  
  //Get object id
  public String getId() {
    return this.id;
  }
  
  //Check if current mouse/finger position is inside the current touch-area
  public boolean isTouched() {
    if(!this.touchable) {
      return false; 
    }
    if(mouseX >= this.touchX && mouseX <= this.touchX+this.touchWidth) {
      if(mouseY >= this.touchY && mouseY <= this.touchY+this.touchHeight) {
        return true; // The current mouse position is inside the touch area of the UiElement
      }
    }
    
    return false; 
  }
  
  //Placeholder function for subclasses to use, this will run whenever this UiElement is beeing touched
  public void touch() {
  }
  
  //Start dragging
  public void drag() {
    if(!this.touchable) {
      return; 
    }
    
    this.dragging = true;
  }
  
  //Stop dragging
  public void drop() {
    if(!this.touchable) {
      return; 
    }
    
    this.dragging = false;
  }
  
  //How to handle mouse press
  public void mousePressed() {
    if(!this.touchable) {
      return; 
    }
    
    if(this.isTouched()) { //We are beeing touched
      this.drag(); //Start dragging
      this.touch(); //Run touch functionality
    } 
  }
  
  //How to handle mouse drag
  public void mouseDragged() {
    if(!this.touchable) {
      return; 
    }
    /*
    if(this.isTouched() || this.dragging == true) { //We are beeing touched OR we are currently beeing dragged
      this.touch(); //Run touch functionality
    }
    */
    if(this.dragging == true) { //We are currently beeing dragged
      this.touch(); //Run touch functionality
    }
  }
  
  //How to handle mouse release
  public void mouseReleased() {
    if(!this.touchable) {
      return; 
    }
    
    this.drop(); //Stop dragging
  }
  
}
