import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import java.util.Timer;
import java.util.TimerTask;

Movie fencecircle;

Capture video;
OpenCV opencv;
PImage silhouette;

boolean detectFaces = false;
int personCount = 0;
int zeroCount = 0;

void setup(){
  
  size(1280, 720);
  
  video = new Capture(this, 1280, 720);
  
  //webcam for the shadow
  opencv = new OpenCV(this, 1280, 720);
  //webcam for Object detection
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
  
  fencecircle = new Movie(this, "FinalVenceVideoBright1080p_24fps_.mp4");
  fencecircle.play();
  //loading the film from files
  
   silhouette = createImage(video.width, video.height, ARGB);
   
   //timer to count faces every 2 secs
    Timer timer = new Timer();
  timer.scheduleAtFixedRate(new TimerTask() {
    public void run() {
      detectFaces = true;
    }
  }, 0, 2500);
}


    

void draw() {

  opencv.loadImage(video);
  
   pushMatrix();
  translate(width, 0);
  scale(-1, 1);

  stroke(0);
  strokeWeight(5);
  textSize(100);
  
 if (detectFaces) {
    opencv.loadImage(video);
    Rectangle[] faces = opencv.detect();
    personCount = faces.length;
    detectFaces = false;
 
    if (personCount == 0) {
      zeroCount++;
      if (zeroCount >= 2) {
        fencecircle.speed(-8);
      }
    } else {
      zeroCount = 0; // Reset the zero count if personCount is not zero
    }
    
    
  if (personCount == 1){
    oneP();
  }
  else if (personCount == 2){
    twoP();
  }
  else if (personCount == 3){
   threeP();
  }
  else if (personCount > 3){
    fourP();
  }
  
  text (personCount, 100, 100);
  }
  
//****************** Pixel Silhouette START ****************

 // Grid determining increment at which to read pixel data
  int gridSize = 3;
  
  // Loading pixels
  video.read();
  video.loadPixels();
  
  // Looping through each pixel reading
  for (int y = 0; y < video.height; y += gridSize) {
    for (int x = 0; x < video.width; x += gridSize) {
      // Formula for getting red value
      int index = (y * video.width + x);
      
     // Assigning RGB colour variables
      int pixelColor = video.pixels[index];
      int r = (pixelColor >> 16) & 0xFF;
     //int g = (pixelColor >> 8) & 0xFF;
     //int b = pixelColor & 0xFF;
      
    // println(r);
    //    println(g);
   // println(b);
      
      if (r <= 150) {
    // Any value above this RGB threshold is pretty white, meaning it is the background (ceiling)
      
        
        rect(x, y, 3, 3);  
        // Drawing a black pixel at the coordinates that are not white like the ceiling, 
        //         meaning they are objects/people that I want to display as a shadow
        tint(255, 160);  
        //applying transparency
      }
    }
  }
//****************** Pixel Silhouette END *************** 

popMatrix();


 image(fencecircle, 0, 0, 1280, 720);
 //drawing the video
}

void captureEvent(Capture c) {
  c.read();
}
  
void movieEvent(Movie m){
  m.read();
}

// functions for speed control
void oneP(){ 
float currentTime = fencecircle.time();

 
  if (currentTime > 11 * 60 + 20) {
    fencecircle.speed(0.5); }// Slow down to half speed  
   else{
     //fencecircle.play();
    fencecircle.speed(1.0);
    }
  
}

void twoP(){
  
  float currentTime = fencecircle.time();

  // Check if the current time is within the range (10:25 to 11:22)
  if (currentTime >= 10 * 60 + 25 && currentTime <= 11 * 60 + 22) {
    fencecircle.speed(1.0); // Set normal speed
  }
    else if (currentTime > 11 * 60 + 20) {
    fencecircle.speed(0.5); // Slow down to half speed  
  } else{
   fencecircle.speed(3.0);
        }
  }

  

void threeP(){
  
  float currentTime = fencecircle.time();

  // Check if the current time is within the range (10:25 to 11:22)
  if (currentTime >= 10 * 60 + 25 && currentTime <= 11 * 60 + 22) {
    fencecircle.speed(1.0); // Set normal speed
  }
  else if (currentTime > 11 * 60 + 20) {
    fencecircle.speed(0.5); // Slow down to half speed  
  } else{
    fencecircle.speed(5.5);
        }
}


void fourP(){
  
  float currentTime = fencecircle.time();

  // Check if the current time is within the range (10:25 to 11:22)
  if (currentTime >= 10 * 60 + 25 && currentTime <= 11 * 60 + 22) {
    fencecircle.speed(1.0); // Set normal speed
  }
    else if (currentTime > 11 * 60 + 20) {
    fencecircle.speed(0.5); // Slow down to half speed  
  } else{
   fencecircle.speed(10.0);
        }
}



  
  
  
  
