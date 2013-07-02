// Button class (extends UiElement class)
// Basic button element, with customizable size, values and graphics
// Coded by Nicolai R. Tellefsen

class Button extends UiElement {
  
  //Values
  private boolean value;
  //Margins
  private float marginTop, marginBottom, marginLeft, marginRight, marginHor, marginVer;
  //Button metrics
  private float buttonX, buttonY, buttonWidth, buttonHeight;
  //Images and image metrics
  private PImage bgImage, btnImage, btnImageActive;
  private boolean bgLoaded = false; //Have we loaded a custom background?
  private int bgWidth = 0;
  private int bgHeight = 0;
  private boolean btnLoaded = false; //Have we loaded a custom button?
  private int btnWidth = 0;
  private int btnHeight = 0;
  private float light = 0;
  
  //Constructor, sets default values and calls the parent-class constructor
  Button(float _x, float _y, float _width, float _height, boolean _value) {
     super(_x,_y,0,_width,_height);
     
     this.width = _width;
     this.height = _height;
     this.setValue(_value);
     this.setMargins(this.width/10);
     
     this.updateButton(this.width-this.marginHor,this.width-this.marginVer);
     this.updateTouchArea();
     this.touchable = true; //Touch has been enabled
     
     rectMode(CENTER);
     imageMode(CENTER);
  }
  
  //Displays the button
  public void display() {
     this.drawBackground();
     this.drawButton();
  }
    
  //Set the current value
  public void setValue(boolean _value) {
    this.value = _value;
  }
  
  //Get the current value
  public boolean getValue() {
    return this.value; 
  }
  
  //Toogle the current value
  public void toogleValue() {
    this.setValue(!this.value);
  }
  
  //Updates the button placement and dimensions
  private void updateButton(float _width, float _height) {
    this.buttonX = this.x;
    this.buttonY = this.y;
    this.buttonWidth = this.width-marginHor;
    this.buttonHeight = this.height-marginVer;
    
    updateTouchArea();
  }
  
  //Draws background color or loads a background image if avaliable
  private void drawBackground() {
    if(this.bgLoaded == true) {
      noFill();
      image(this.bgImage,this.x,this.y);
      return; 
    }
    
    fill(255);
    noStroke();
    rect(this.x,this.y, this.width, this.height);
  }
  
  //Draws button or loads a button image if avaliable
  private void drawButton() {
    this.updateButton(this.buttonWidth,this.buttonHeight);
    
    if(this.btnLoaded == true) {
      if(this.getValue() == true) {
        light = 1; 
      }
      
      if(this.getValue() == false && light > 0) {
        light -= 0.3; 
      }
      if(light < 0) {
        light = 0; 
      }
      
      noFill();
      image(this.btnImage,this.buttonX,this.buttonY);
      tint(255,255*light);
      image(this.btnImageActive,this.buttonX,this.buttonY);
      tint(255,255);
      
      return;
      /*
      noFill();
      if(this.getValue() == true) {
        image(this.btnImageActive,this.buttonX,this.buttonY);
      } else {
        light = 1;
        tint(255,20);
        image(this.btnImage,this.buttonX,this.buttonY);
        tint(255,255);
      }
      return;
      */
    }
    
    fill(255,0,0);
    if(this.getValue() == true) {
      fill(0,255,0);
    }
    noStroke();
    rect(this.buttonX, this.buttonY, this.buttonWidth, this.buttonHeight);
  }
  
  //Moves the touch area to the current button position
  private void updateTouchArea() {
    this.touchX = this.buttonX-this.buttonWidth/2;
    this.touchY = this.buttonY-this.buttonHeight/2;
    this.touchWidth = this.buttonWidth;
    this.touchHeight = this.buttonHeight;
  }
  
  //Whenever we are beeing touched move button according to mouse movements and update value accordingly
  public void touch() {
    this.setValue(!this.value);
  }
  
  //Load a background image
  public boolean loadBackground(String _filePath, int _fileWidth, int _fileHeight) {
    this.bgImage = loadImage(_filePath);
    this.bgWidth = _fileWidth;
    this.bgHeight = _fileHeight;
    
    this.width = this.bgWidth;
    this.height = this.bgHeight;
    
    this.bgLoaded = true;
    return true; 
  }

  //Load a button image
  public boolean loadButton(String _filePath, String _filePathActive, int _fileWidth, int _fileHeight) {
    this.btnImage = loadImage(_filePath);
    this.btnImageActive = loadImage(_filePathActive);
    this.btnWidth = _fileWidth;
    this.btnHeight = _fileHeight;
    
    this.setMargins(0); // Adjustments spesific to this image, should be replaced with more elegant and flexible solution
    this.updateButton (_fileWidth,_fileHeight);
    
    this.btnLoaded = true;
    this.changeTouchSize(this.btnWidth,this.btnHeight);
    return true; 
  }
  
  //Set margins (space between the button and the edge of the background
  private void setMargins(float _marginLeft, float _marginRight,float _marginTop, float _marginBottom) {
    this.marginTop = _marginTop;
    this.marginBottom = _marginBottom;
    this.marginLeft = _marginLeft;
    this.marginRight = _marginRight;
    this.marginHor = _marginLeft+_marginRight;
    this.marginVer = _marginTop+_marginBottom;
  }
  private void setMargins(float _marginHor, float _marginVer) {
    this.setMargins(_marginHor,_marginHor,_marginVer,_marginVer);
  }
  private void setMargins(float _margins) {
    this.setMargins(_margins,_margins,_margins,_margins);
  }
  
}
