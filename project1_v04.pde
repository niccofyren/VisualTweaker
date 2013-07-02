/* @pjs preload="button_bg_40x40.jpg, button_on_bg_40x40.jpg, clip1_0.jpg, clip1_1.jpg, clip1_10.jpg, clip1_11.jpg, clip1_12.jpg, clip1_13.jpg, clip1_14.jpg, clip1_15.jpg, clip1_16.jpg, clip1_17.jpg, clip1_18.jpg, clip1_2.jpg, clip1_3.jpg, clip1_4.jpg, clip1_5.jpg, clip1_6.jpg, clip1_7.jpg, clip1_8.jpg, clip1_9.jpg, clip2_0.jpg, clip2_1.jpg, clip2_2.jpg, clip2_3.jpg, clip2_4.jpg, clip2_5.jpg, clip2_6.jpg, clip2_7.jpg, clip3_0.jpg, clip3_1.jpg, clip3_10.jpg, clip3_11.jpg, clip3_12.jpg, clip3_2.jpg, clip3_3.jpg, clip3_4.jpg, clip3_5.jpg, clip3_6.jpg, clip3_7.jpg, clip3_8.jpg, clip3_9.jpg, slider_bg_120x320.jpg, slider_button_59x100.png"; 
 */
 
/* Todo
- Limit to avoid Infinity from getAveragePower() js
- Update maxim.js and try to get proper value ranges directly from the source (or make own custom function to replace getPowerSpectrum
*/

//Object containers/arrays
Slider[] sliders = new Slider[10]; //An array of Sliders (UiElements)
Button[] buttons = new Button[10]; //An array of buttons (UiElements)
Object[] clips = new Object[0]; //An array of movie clips
PImage[] clip; //An array of all the pictures inside a movie clip
Maxim maxim; //Maxim library object
AudioPlayer player; //The sound-clip player

//List of current state and avaliable states
String [] states = new String[9]; //Holds a list off states to choose between
MoviePlayer moviePlayer; //Shows the movie
AudioVisualizer audioVisualizer; //Show visualizer
State currentState; //Holds the active state
MoviePlayback moviePlayback; //Show movie and speed controls
MovieColor movieColor; //Show movie and color controls
MovieColorCycle movieColorCycle; //Show movie and color controls
AudioAdjust audioAdjust; //Show audio controls

//Default values for various filters
int currentFrame = 0; //The current movie frame
int currentClip = 0; //The current movie clip
int speed = 1; //The current playback speed
int framerate = 25; //The active framerate target (if the device is fast enough)
int rFilter = 255; //Red filter
float rStrength = 1; //The strength of the filter
int r = 255;
int gFilter = 0; //Green filter
float gStrength = 1; //The strength of the filter
int g = 0;
int bFilter = 80; //Blue filter
float bStrength = 1; //The strength of the filter
int b = 80;
float rCycleSpeed = 0; //The speed at which we adjust the strength of the red color filter
float rCycleDirection = 1;
float gCycleSpeed = 0; //The speed at which we adjust the strength of the green color filter
float gCycleDirection = 1;
float bCycleSpeed = 0; //The speed at which we adjust the strength of the blue color filter
float bCycleDirection = 1;
float audioVolume = 1;
float audioThreshold = 0.5;
float audioWait = 10;

//Default values
int rectModeDefault = CENTER;

void setup() {
  // ******* General *******
  size(360,640); //Screen size, and 2D or 3D mode. 3D does not work in javascript mode :/
  frameRate(framerate); //The starting framerate
  background(0); //Set the default background color
  
  // ******* States *******
  //Populate all the states we are going to use
  moviePlayback = new MoviePlayback();
  moviePlayback.setName("Movie playback");
  states[0] = "moviePlayback";
  movieColor = new MovieColor();
  movieColor.setName("Movie color adjustments");
  states[1] = "movieColor";
  movieColorCycle = new MovieColorCycle();
  movieColorCycle.setName("Movie color cycle");
  states[2] = "movieColorCycle";
  audioAdjust = new AudioAdjust();
  audioAdjust.setName("Audio adjustments");
  states[3] = "audioAdjust_1";
  states[4] = "audioAdjust_2";
  states[5] = "audioAdjust_3";
  states[6] = "audioAdjust_4";
  states[7] = "audioAdjust_5";
  states[8] = "audioAdjust_6";
  //Special states that can not be selected by the user
  moviePlayer = new MoviePlayer();
  moviePlayer.setName("Movie player");
  audioVisualizer = new AudioVisualizer();
  audioVisualizer.setName("Audio visualizer - 1");
  
  changeState("moviePlayback"); //Define the first state we are going to use
  
  // ******* Video *******
  clip = loadImages("clip1",".jpg",19); //Load all frames in our clip
  clips = (Object []) append(clips,clip); //Store clip in the clip array 
  
  clip = loadImages("clip2",".jpg",7); //Load all frames in our clip
  clips = (Object []) append(clips,clip); //Store clip in the clip array 
  
  clip = loadImages("clip3",".jpg",12); //Load all frames in our clip
  clips = (Object []) append(clips,clip); //Store clip in the clip array 
  
  // ******* Sound *******
  maxim = new Maxim(this);
  player = maxim.loadFile("anewdawnbreaks.wav");
  player.setLooping(true);
  //player.setVolume(1.0);
  player.setAnalysing(true);
  
  // ******* Buttons *******
  for(int i=0; i<states.length; i++) {
    buttons[i] = new Button(20+(40*i),height/2-20,40,40,false);
    buttons[i].loadBackground("button_bg_40x40.jpg",40,40);
    buttons[i].loadButton("button_bg_40x40.jpg","button_on_bg_40x40.jpg",40,40);
  }
}

void draw() {
  // ******* Start audio player *******
  player.play();
  //player.setVolume(audioVolume); //This does not work in javascript mode
  
  // ******* Cycle color values *******
  if(rCycleSpeed != 0) {
    rStrength = rStrength + (rCycleSpeed/10)*rCycleDirection;
    if(rStrength > 1 || rStrength < 0) {
      rCycleDirection *= -1;
    }
  } else {
    rStrength = 1; 
  }
  if(gCycleSpeed != 0) {
    gStrength = gStrength + (gCycleSpeed/10)*gCycleDirection;
    if(gStrength > 1 || gStrength < 0) {
      gCycleDirection *= -1;
    }
  } else {
    gStrength = 1; 
  }
  if(bCycleSpeed != 0) {
    bStrength = bStrength + (bCycleSpeed/10)*bCycleDirection;
    if(bStrength > 1 || bStrength < 0) {
      bCycleDirection *= -1;
    }
  } else {
    bStrength = 1; 
  }

  r = (int) Math.floor(rFilter*rStrength);
  g = (int) Math.floor(gFilter*gStrength);
  b = (int) Math.floor(bFilter*bStrength);
  
  // ******* Run current state *******
  currentState.run();
  
  // ******* Display state text *******
  textSize(11);
  textAlign(CENTER);
  fill(255,255,255,30);
  text(currentState.getName(), width/2, height-11);  
  
  // ******* Display default buttons *******
  for(int i=0; i<states.length; i++) {
    if(buttons[i].getValue() == true) {
      changeState(states[i]);
    }
    buttons[i].display();
    buttons[i].setValue(false);
  }
  
  // ******* Adjust framerate *******
  frameRate(framerate);
}

void mousePressed() {
  //Let the current state know what is happening (could propably be handled more elegant by using some sort of java event triggers
  currentState.mousePressed();
  
  //Send mouse release information to the default buttons
  for(int i=0; i<states.length; i++) {
    buttons[i].mousePressed();
  }
}

void mouseDragged() {
  //Let the current state know what is happening (could propably be handled more elegant by using some sort of java event triggers
  currentState.mouseDragged();
}

void mouseReleased() {
  //Let the current state know what is happening (could propably be handled more elegant by using some sort of java event triggers
  currentState.mouseReleased();
}

//Change the active state
void changeState(String _stateId) {
  
  //This should be a switch. But to ensure support in Java, who don't support switch(String xx) we have to use a if-else
  if(_stateId == "moviePlayback"){
    currentState = moviePlayback;
  } else if(_stateId == "movieColor"){
    currentState = movieColor;
  } else if(_stateId == "movieColorCycle"){
    currentState = movieColorCycle;
  } else if(_stateId == "audioAdjust_1") {
    currentState = audioAdjust;
    audioVisualizer.changeEffect(0);
  } else if(_stateId == "audioAdjust_2") {
    currentState = audioAdjust;
    audioVisualizer.changeEffect(1);
  } else if(_stateId == "audioAdjust_3") {
    currentState = audioAdjust;
    audioVisualizer.changeEffect(2);
  } else if(_stateId == "audioAdjust_4") {
    currentState = audioAdjust;
    audioVisualizer.changeEffect(3);
  } else if(_stateId == "audioAdjust_5") {
    currentState = audioAdjust;
    audioVisualizer.changeEffect(4);
  } else if(_stateId == "audioAdjust_6") {
    currentState = audioAdjust;
    audioVisualizer.changeEffect(5);  
  } else {
    currentState = moviePlayback;
  }
  
  currentState.activate(); //Activate the new state
}

//Image loading borrowed from MIT example
PImage[] loadImages(String _fileName, String _fileExtension, int _fileCount) {
  PImage[] images = new PImage[0];
  for(int i=0; i<_fileCount; i++) {
    //String id = String.format("%02d",i);
    PImage img = loadImage(_fileName+"_"+i+_fileExtension);
    if(img != null) {
       images = (PImage [])append(images,img); 
    } else {
       break; 
    }
  }
  return images;
}
