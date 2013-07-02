// Slider class (extends UiElement class)
// Basic slider element, with customizable size, values and graphics
// Coded by Nicolai R. Tellefsen

// Todo: Add support for custom getFilteredValue method, Add support for boolean values

class Slider extends UiElement {
  
  //Values
  private float min, max, value;
  //Margins
  private float marginTop, marginBottom, marginLeft, marginRight, marginHor, marginVer;
  //Button metrics
  private float buttonX, buttonY, buttonWidth, buttonHeight;
  //Images and image metrics
  private PImage bgImage, btnImage;
  private boolean bgLoaded = false; //Have we loaded a custom background?
  private int bgWidth = 0;
  private int bgHeight = 0;
  private boolean btnLoaded = false; //Have we loaded a custom button?
  private int btnWidth = 0;
  private int btnHeight = 0;
  
  //Constructor, sets default values and calls the parent-class constructor
  Slider(float _x, float _y, float _width, float _height, float _min, float _max) {
     super(_x,_y,0,_width,_height);
     
     this.width = _width;
     this.height = _height;
     this.min = _min;
     this.max = _max;
     this.setValue(this.min);
     this.setMargins(this.width/10);
     
     this.updateButton(this.width-this.marginHor,this.width-this.marginVer);
     this.addTouch(this.buttonX,this.buttonY,this.buttonHeight,this.buttonWidth);
     
     rectMode(CENTER);
     imageMode(CENTER);
  }
  
  //Displays the slider
  public void display() {
     this.drawBackground();
     this.drawButton();
     this.moveTouchArea();
     
     textSize(11);
     textAlign(CENTER);
     fill(255,255,255,40);
     text(this.getId(), this.x, this.y-this.height/2+marginTop/2+10);  
  }
  
  //Changes the current max and min values
  public boolean setRange(float _min, float _max, float _value) {
    this.min = _min;
    this.max = _max;
    
    this.setValue(_value);
    return true;
  }
  public boolean setRange(float _min, float _max) {
    return this.setRange(_min,_max,this.value);
  }
  
  //Set the current value (_loose enables all out of range variables to be adjusted to the valid range)
  public boolean setValue(float _value, boolean _loose) {
    if(_loose == false) {
      if(_value <= this.max && _value >= this.min) {
        this.value = _value;
        return true;
      } else {
        return false; 
      }
    }
    
    if(_value > this.max) {
      this.value = this.max;
      return true;
    }
    
    if(_value < this.min) {
      this.value = this.min;
      return true;
    }
    
    this.value = _value;
    return true; 
  }
  public boolean setValue(float _value) {
    return setValue(_value, true);
  }
    public float getValue() {
    return this.value; 
  }
  
  //Increases the current value
  public void increaseValue(float _increase) {
    this.setValue(this.getValue()+_increase, true);  
  }
  
  //Decreases the current value
  public void decreaseValue(float _decrease) {
    this.setValue(this.getValue()-_decrease, true);  
  }
  
  //Updates the button placement and dimensions
  private void updateButton(float _width, float _height) {
    float _maxPosition = this.y-this.height/2+marginTop+this.buttonHeight/2;
    float _minPosition = this.y+this.height/2-marginBottom-this.buttonHeight/2;
    float _rangeDistance = Math.abs(this.max-this.min);
    float _rangePosition = ((Math.abs(this.value-this.min)/_rangeDistance)*(_maxPosition-_minPosition))+_minPosition;
    //_position *= -1;

    this.buttonX = this.x+this.width/2-this.buttonWidth/2-marginHor/2;
    this.buttonY = _rangePosition;
    this.buttonWidth = _width;
    this.buttonHeight = _height;
    
    moveTouchArea();
  }
  
  //Draws background color or loads a background image if avaliable
  private void drawBackground() {
    if(this.bgLoaded == true) {
      noFill();
      image(this.bgImage,this.x,this.y);
      return; 
    }
    
    fill(255);
    rect(this.x,this.y, this.width, this.height);
  }
  
  //Draws button or loads a button image if avaliable
  private void drawButton() {
    this.updateButton(this.buttonWidth,this.buttonHeight);
    
    if(this.btnLoaded == true) {
      noFill();
      image(this.btnImage,this.buttonX,this.buttonY);
      return;
    }
    
    fill(255,0,0);
    rect(this.buttonX, this.buttonY, this.buttonWidth, this.buttonHeight);
  }
  
  //Moves the touch area to the current button position
  private void moveTouchArea() {
    this.touchX = this.buttonX-this.buttonWidth/2; //this.x+this.buttonX-this.buttonWidth/2;
    this.touchY = this.buttonY-this.buttonHeight/2; //this.y+this.buttonY-this.buttonHeight/2;
  }
  
  //Whenever we are beeing touched move button according to mouse movements and update value accordingly
  public void touch() {
    float _rangeMax = this.y-this.height/2+marginTop+this.buttonHeight/2;
    float _rangeMin = this.y+this.height/2-marginBottom-this.buttonHeight/2;
    float _rangeDistance = Math.abs(_rangeMax-_rangeMin);
    float _rangeLocation = 1-((mouseY-_rangeMax)/_rangeDistance);
    
    _rangeLocation = (_rangeLocation < 0 ? 0 : _rangeLocation);
    _rangeLocation = (_rangeLocation > 1 ? 1 : _rangeLocation);
    
    float _valueRange = this.max-this.min;
    float _value = (_valueRange*_rangeLocation)+this.min;
    
    this.setValue(_value,true);
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
  public boolean loadButton(String _filePath, int _fileWidth, int _fileHeight) {
    this.btnImage = loadImage(_filePath);
    this.btnWidth = _fileWidth;
    this.btnHeight = _fileHeight;
    
    this.setMargins((this.width-this.btnWidth)/2, (this.width-this.btnWidth)/2, (this.width-this.btnWidth)/4, -2); // Adjustments spesific to this image, should be replaced with more elegant and flexible solution
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
