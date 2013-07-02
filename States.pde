// State class
// Generic class for showing different states/screens and providing a framework for them to get triggered by
// This propably needs a lot of work before working elegantly, and beeing totaly independent... but it works for now
// Coded by Nicolai R. Tellefsen
public class State {
 protected String name;
 protected boolean firstRun = true;
 State() {
 }
 public String getName() {
   return this.name; 
 }
 public void setName(String _name) {
   this.name = _name; 
 }
 public void activate() {
 }
 public void deactivate() {
 }
 public void run() {
 }
 public void background() {
 }
 public void mousePressed() {
 }
 public void mouseDragged() {
 }
 public void mouseReleased() {
 }
}

// ****************************
// Movie playing mode
// ****************************

public class MoviePlayback extends State {
    
  public void activate() {
    for(int i = 0; i<3; i++) {
      sliders[i] = new Slider(60+((i)*120),height-160,120,320,-2,2);
      sliders[i].loadBackground("slider_bg_120x320.jpg",120,320);
      sliders[i].loadButton("slider_button_59x100.png",59,100);
      sliders[i].setValue(0);
    }
    
    sliders[0].setRange(0,2,currentClip); //Adjust clip
    sliders[0].setId("Clip");
    sliders[1].setRange(-1,1,speed); //Adjust playback direction
    sliders[1].setId("Direction");
    sliders[2].setRange(10,120,framerate); //Adjust framerate 
    sliders[2].setId("Framerate");
    
    this.firstRun = false;
  }
  
  public void run() {
    // ******* Display the movieplayer *******
    moviePlayer.run();
    
    // ******* Display the sliders *******
    for(int i = 0; i<3; i++) {
      sliders[i].display();
    }
    
    currentClip = (int) sliders[0].getValue();
    speed = (int) Math.round(sliders[1].getValue());
    framerate = (int) (sliders[2].getValue());
  }
  
  public void background() {
    
  }
  
  public void mousePressed() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mousePressed();
    } 
  }
  
  public void mouseDragged() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseDragged();
    } 
  }
  
  public void mouseReleased() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseReleased();
    } 
  }
  
}


// ****************************
// Movie color mode
// ****************************

public class MovieColor extends State {
  public void activate() {
    for(int i = 0; i<3; i++) {
      sliders[i] = new Slider(60+((i)*120),height-160,120,320,-2,2);
      sliders[i].loadBackground("slider_bg_120x320.jpg",120,320);
      sliders[i].loadButton("slider_button_59x100.png",59,100);
      sliders[i].setValue(0);
    }
    sliders[0].setRange(0,255,rFilter); //Adjust r
    sliders[0].setId("Red");
    sliders[1].setRange(0,255,gFilter); //Adjust g
    sliders[1].setId("Green");
    sliders[2].setRange(0,255,bFilter); //Adjust b
    sliders[2].setId("Blue");
    
    this.firstRun = false;
  }
  
  public void run() {
    // ******* Display the movieplayer *******
    moviePlayer.run();
    
    // ******* Display the sliders *******
    for(int i = 0; i<3; i++) {
      sliders[i].display();
    }
    
    rFilter = (int) sliders[0].getValue();
    gFilter = (int) sliders[1].getValue();
    bFilter = (int) sliders[2].getValue();    
  }
  
  public void mousePressed() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mousePressed();
    } 
  }
  
  public void mouseDragged() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseDragged();
    } 
  }
  
  public void mouseReleased() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseReleased();
    } 
  }
  
}


// ****************************
// Movie color cycle mode
// ****************************

public class MovieColorCycle extends State {
  public void activate() {
    for(int i = 0; i<3; i++) {
      sliders[i] = new Slider(60+((i)*120),height-160,120,320,-2,2);
      sliders[i].loadBackground("slider_bg_120x320.jpg",120,320);
      sliders[i].loadButton("slider_button_59x100.png",59,100);
      sliders[i].setValue(0);
    }
    sliders[0].setRange(0,1,rCycleSpeed); //Adjust r cycle speed
    sliders[0].setId("Red cycle");
    sliders[1].setRange(0,1,gCycleSpeed); //Adjust g cycle speed
    sliders[1].setId("Green cycle");
    sliders[2].setRange(0,1,bCycleSpeed); //Adjust b cycle speed
    sliders[2].setId("Blue cycle");
    
    this.firstRun = false;
  }
  
  public void run() {
    // ******* Display the movieplayer *******
    moviePlayer.run();
    
    // ******* Display the sliders *******
    for(int i = 0; i<3; i++) {
      sliders[i].display();
    }
    
    rCycleSpeed = sliders[0].getValue();
    gCycleSpeed = sliders[1].getValue();
    bCycleSpeed = sliders[2].getValue();    
  }
  
  public void mousePressed() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mousePressed();
    } 
  }
  
  public void mouseDragged() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseDragged();
    } 
  }
  
  public void mouseReleased() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseReleased();
    } 
  }
  
}

// ****************************
// Audio adjustments mode
// ****************************

public class AudioAdjust extends State {
  private RangeNormalizer power = new RangeNormalizer();
  private float wait;
  
  public void activate() {
    for(int i = 0; i<3; i++) {
      sliders[i] = new Slider(60+((i)*120),height-160,120,320,-2,2);
      sliders[i].loadBackground("slider_bg_120x320.jpg",120,320);
      sliders[i].loadButton("slider_button_59x100.png",59,100);
      sliders[i].setValue(0);
    }
    sliders[0].setRange(0,1,audioThreshold); //Adjust audio threshold (this will vary wildly between platforms
    sliders[0].setId("Threshold");
    sliders[1].setRange(0,1,0); //Adjust beat "slider"
    sliders[1].setId("Beat detector");
    sliders[1].removeTouch();
    sliders[2].setRange(0,1,power.getRatio()); //Adjust power "slider"
    sliders[2].setId("Power");
    sliders[2].removeTouch();
    
    wait = audioWait;
    
    audioVisualizer.activate();
    
    this.firstRun = false;
  }
  
  public void run() {
    // ******* Calculate variables *******
    power.setValue(player.getAveragePower());
    sliders[2].setValue(power.getRatio());
    
    if((power.getRatio() > audioThreshold && wait <= 0)) {
      sliders[1].setValue(1);
      audioVisualizer.beat();
      wait = audioWait;
    } else if(wait > 0 || sliders[1].getValue() > 0) {
      sliders[1].setValue(sliders[1].getValue()*0.9);
    }
    
    if(wait > 0) {
      wait -= 1;
    }
    
    // ******* Display the movieplayer *******
    //moviePlayer.run();
    
    // ******* Display the visualizer *******
    audioVisualizer.run();
    
    // ******* Display the sliders *******
    for(int i = 0; i<3; i++) {
      sliders[i].display();
    }
    
    audioThreshold = sliders[0].getValue();
    //gCycleSpeed = sliders[1].getValue();
    //bCycleSpeed = sliders[2].getValue();
    //player.setVolume(audioVolume);
  }
  
  public void mousePressed() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mousePressed();
    } 
    audioVisualizer.mousePressed();
  }
  
  public void mouseDragged() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseDragged();
    }
    audioVisualizer.mouseDragged();
  }
  
  public void mouseReleased() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseReleased();
    } 
    audioVisualizer.mouseReleased();
  }
  
}

// ****************************
// Movie player
// ****************************

public class MoviePlayer extends State {
  public void activate() {
    this.firstRun = false;
  }
  
  public void run() {
    PImage[] _clip = (PImage[])clips[currentClip];
    
    if(currentFrame+1 > _clip.length) {
      currentFrame = 0;
    }
    if(currentFrame < 0) {
      currentFrame = _clip.length-1;
    }
    
    PImage frameOriginal = _clip[currentFrame];
    PImage frameNew = createImage(frameOriginal.width,frameOriginal.height,RGB);
    
    frameOriginal.loadPixels();
    frameNew.loadPixels();
    
    for(int x = 0; x<frameOriginal.width; x++) {
      for(int y = 0; y<frameOriginal.height; y++) {
        int loc = x + y * frameOriginal.width;
        
        int r = (int) Math.floor(rFilter*rStrength);
        int g = (int) Math.floor(gFilter*gStrength);
        int b = (int) Math.floor(bFilter*bStrength);
        
        color c = frameOriginal.pixels[loc];
        c = color(r+red(c),g+green(c),b+blue(c));
        
        frameNew.pixels[loc] = c;    
      }
    }
    
    frameNew.updatePixels();
    
    image(frameNew,width/2,frameNew.height/2);
    currentFrame += speed;
  }
  
  public void mousePressed() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mousePressed();
    } 
  }
  
  public void mouseDragged() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseDragged();
    } 
  }
  
  public void mouseReleased() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseReleased();
    } 
  }
  
}


// ****************************
// Visualizers
// ****************************

public class AudioVisualizer extends State {
  //Size and position
  public float x;
  public float centerX;
  public float y;
  public float centerY;
  public float width;
  public float height;
  
  //Current effect
  private int effectDefault = 0;
  private int effect = effectDefault;
  private int effectMax = 6;
  
  //Visual size
  private float sizeDefault = this.width/20;
  private float size = sizeDefault;
  //Stroke color and weight
  private color strokeColorDefault = color(255);
  private color strokeColor = strokeColorDefault;
  private float strokeWidthDefault = 3;
  private float strokeWidth = strokeWidthDefault; //original name is reserved by the strokeWeight function
  
  //Number of elements
  private int elements = 30;
  
  //Time
  private int time = 0;
  
  //Audio data
  private float [] spectrum;
  private RangeNormalizer spectrumNormalizer = new RangeNormalizer(); //Custom class to normalize the difference in spectrum values across platforms
  private float strength = 0;
  private float [] strengthArray = new float[elements];
  private float [] strengthHistory = new float[elements]; //Historical archive of previous values
  private color [] colorHistory = new color[elements]; //Historical archive of previous values
  
  public void activate() {
    this.x = 0;
    this.y = 0;
    this.width = 360;
    this.height = 280;
    this.centerX = this.x + this.width/2;
    this.centerY = this.y + this.height/2;
    
    for(int i = 0; i < this.strengthHistory.length; i++) {
      this.strengthHistory[i] = 0;
    }
    this.strengthHistory[0] = this.strength;
    
    for(int i = 0; i < this.colorHistory.length; i++) {
      this.colorHistory[i] = color(r,g,b);
    }
    
    fill(0,0,0);
    noStroke();
    rect(this.centerX,this.centerY,this.width,this.height);
    
    this.firstRun = false;
  }
  
  public void run() {
    this.strengthHistory[0] = this.strength;
    this.colorHistory[0] = color(r,g,b);
    for(int i = this.elements-1; i > 0; i--) {
      this.strengthHistory[i] = this.strengthHistory[i-1];
      this.colorHistory[i] = this.colorHistory[i-1];
    }
    
    // ******* Analyze *******
    float [] _spectrumTemp = player.getPowerSpectrum();
    this.spectrum = new float[_spectrumTemp.length-90];
    for(int i = 10; i < _spectrumTemp.length-100; i++) { //Cuts of the top 100 and bottom 10 frequencies, these seem to add a lot of "noise" to the data on javascript
      this.spectrumNormalizer.setValue(_spectrumTemp[i]); //Get the current values and feed them to the normalizer
      this.spectrum[i-10] = this.spectrumNormalizer.getRatio(); //Returns a value between 0 and 1 based relation to previous values, gets more accurate over time
    }
    
    // ******* Display *******
    if(this.spectrum != null) {
        this.showEffect();
    }
    
    // ******* Pass time and adjust variables *******
    this.time += 1;
    this.strength = (this.strength > 0) ? this.strength*0.9 : 0;
  }
  
  //We have detected a beat in the music (or something else wants a similar reaction)
  public void beat() {
     this.strength = 1;
  }
  
  //Change what effect is currently active
  public void changeEffect(int _effect) {
    if(_effect < this.effectMax) {
      this.effect = _effect;
    }
  }
  public void changeEffect() {
    if(this.effect < this.effectMax) {
      this.effect += 1;
    } else {
      this.effect = 0; 
    }
  }
  
  //Show the currently active effect
  private void showEffect() {
    float _strength;
    float _range;
    ellipseMode(CENTER);
    
    switch(this.effect) {
      
      // ******* Effect 0 *******
      // ******* Spagetti beat analyser *******   
      case 0:
        fill(0,0,0,150);
        noStroke();
        rect(this.centerX,this.centerY,this.width,this.height);
        noFill();
        
        for(int i=0; i < this.elements; i++) {
          float _i = (float) i;
          stroke(r+10*this.strengthHistory[i],g+10*this.strengthHistory[i],b+10*this.strengthHistory[i]);
          strokeWeight((this.strokeWidth*3)*(_i/this.elements));
          float _size = (this.width*0.8)*(_i/this.elements)+(this.strokeWidth*2*_i)+(this.time%((this.strokeWidth*5)*(_i/this.elements)));
          ellipse(this.centerX+random(this.strength*_i)-this.strength*(_i/2), this.centerY+random(this.strength*_i)-this.strength*(_i/2), _size, _size);
        }
        break;

      // ******* Effect 1 *******
      // ******* Historic-shuffle beat analyser ******* 
      case 1:
        fill(0,0,0,10);
        noStroke();
        rect(this.centerX,this.centerY,this.width,this.height);
        //noFill();
        
        for(int i=0; i < elements; i++) {
          stroke(r*strengthHistory[i],g*strengthHistory[i],b*strengthHistory[i]);
          strokeWeight((strokeWidth*3)*i/elements);
          ellipse(this.centerX, this.centerY, ((width+width/3)*(i/elements)+strokeWidth*3*i)+(time%(strokeWidth*3*i)), ((width+width/3)*(i/elements)+strokeWidth*3*i)+(time%(strokeWidth*3*i)));
        }
        break;
        
      // ******* Effect 2 *******
      // ******* Circular spectrum analyser *******  
      case 2:
        fill(0);
        noStroke();
        rect(this.centerX,this.centerY,this.width,this.height);
        noFill();

        _range = 25; //(float) Math.ceil((this.width/2)/strokeWidthDefault);
        float _size = 0;
        float _stroke = 5;
        
        for(int i=0; i < _range; i++) {
          if(this.spectrum[i] > audioThreshold && this.strengthArray[i] <= 0) {
            this.strengthArray[i] = this.spectrum[i];
          } else { 
            this.strengthArray[i] -= 0.1;
          }
          
          stroke(r*this.strengthArray[i],g*this.strengthArray[i],b*this.strengthArray[i]);
          
          strokeWeight(_stroke * 4 * ( ((float) i) / _range) );
          _size += (_stroke * 4 * ( ((float) i) / _range))*2;
          ellipse(this.centerX, this.centerY, Math.round(_size), Math.round(_size));
        }
        
        break;
        
      // ******* Effect 3 *******
      // ******* Circular pulse-ball *******   
      case 3:
        fill(0,0,0,50);
        noStroke();
        rect(this.centerX,this.centerY,this.width,this.height);
        noFill();
        
        strokeWeight(this.strokeWidth);
        
        _strength = strength-0.7;
        if(_strength < 0) {
          _strength = 0;
        }
        
        for(int i = 0; i<this.elements; i++) {
          float _i = (float) i;
          stroke(r*(_i/this.elements),g*(_i/this.elements),b*(_i/this.elements));
          ellipse(this.centerX,this.centerY,(this.width*0.8*(_i/this.elements)+size+(this.strokeWidth*i*4))*(1-_strength),(width*0.8*(_i/this.elements)+this.size+(this.strokeWidth*i*4))*(1-_strength));
        }
        break;
        
      // ******* Effect 4 *******
      // ******* Circular tunnel of lights *******   
      case 4:
        fill(0);
        noStroke();
        rect(this.centerX,this.centerY,this.width,this.height);
        noFill();
        
        float _spacing = 0;
        float _strokeWeight = 0;
        
        for(int i = 0; i<this.elements; i++) {
          float _i = (float) i;
          int _r = (int) red(this.colorHistory[i]);
          int _g = (int) green(this.colorHistory[i]);
          int _b = (int) blue(this.colorHistory[i]);
          _strokeWeight = (float) Math.round(0.5*_i);
          _spacing += _strokeWeight*2;
          
          if(this.strengthHistory[i] >= 1) {
            stroke(255); 
          } else {
            stroke((_r+(255*(this.strengthHistory[i]/2)))*(_i/this.elements),(_g+(255*(this.strengthHistory[i]/2)))*(_i/this.elements),(_b+(255*(this.strengthHistory[i]/2)))*(_i/this.elements));
          }
          strokeWeight(_strokeWeight+1);
          
          if(i == 0) {
            if(this.strength == 1) {
              fill(255);
            }
            ellipse(this.centerX, this.centerY, 21+_spacing*this.strength, 21+_spacing*this.strength);
            noFill();
          } else {
            ellipse(this.centerX, this.centerY, 20+_spacing, 20+_spacing);
          }
        }
        break;
      
      // ******* Effect 5 *******
      // ******* Linear spectrum analyser *******  
      case 5:
        fill(r,g,b,10);
        noStroke();
        rect(this.centerX,this.centerY,this.width,this.height);
        noFill();
        
        rectMode(CORNER);
        strokeCap(SQUARE);
        float _barWidth = this.width/this.elements;
        float _barHeight = 0;
        _range = 25; //(float) Math.ceil((this.width/2)/strokeWidthDefault);
        
        for(int i=0; i < this.elements; i++) {
          float _i = i;
          
          _barHeight = map(this.spectrum[i],0.5,1,0,this.height);
          
          noFill();
          if(this.spectrum[i] > audioThreshold) {
            stroke(255);
          } else {
            stroke(r*this.spectrum[i],g*this.spectrum[i],b*this.spectrum[i]);
          }
          strokeWeight(strokeWidthDefault);
          line(this.x+_barWidth*_i, this.y+this.height-_barHeight, this.x+_barWidth*_i+_barWidth-1, this.y+this.height-_barHeight);
          
          for(int u = 1; u < _barHeight/5; u++) {
            stroke(255,255,255,(255*this.spectrum[i])*(1-(u/(_barHeight/10))));
            line(this.x+_barWidth*_i, this.y+this.height-_barHeight+strokeWidthDefault*2*u, this.x+_barWidth*_i+_barWidth-1, this.y+this.height-_barHeight+strokeWidthDefault*2*u);
          }
        }
        
        rectMode(CENTER);
        strokeCap(ROUND);
        break;
      
      // ******* If no effect is defined, reset to default *******
      default:
        this.effect = this.effectDefault;
        this.showEffect();
        break;
    }
    
    ellipseMode(CORNER);
  }
        
  public void mousePressed() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mousePressed();
    }
  }
  
  public void mouseDragged() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseDragged();
    } 
  }
  
  public void mouseReleased() {
    //Let the sliders know what the mouse is doing
    for(int i = 0; i<3; i++) {
      sliders[i].mouseReleased();
    } 
  }
  
}
