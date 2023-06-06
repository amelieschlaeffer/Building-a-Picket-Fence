import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Movie fencecircle;

Capture video;
OpenCV opencv;
PImage silhouette;

void setup(){
  
  size(1280, 720);
  
  video = new Capture(this, 1280, 720);
  //webcam for the shadow
  opencv = new OpenCV(this, 1280, 720);
  //webcam for Object detection
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
  
  fencecircle = new Movie(this, "FenceVid10fps_720p.mp4");
  fencecircle.play();
  //loading the film from files
  
   silhouette = createImage(video.width, video.height, ARGB);
}
    

void draw() {

  opencv.loadImage(video);

 
  stroke(0);
  strokeWeight(5);
  textSize(100);
  
  Rectangle[] faces = opencv.detect();
  println(faces.length);
 int personcount = faces.length;
     
 
  if (personcount == 0){
    zeroP();
  }
  else if (personcount == 1){
    oneP();
  }
  else if (personcount == 2){
    twoP();
  }
  else if (personcount == 3){
   threeP();
  }
  else if (personcount > 3){
    fourP();
  }
  
//for (int i = 0; i < faces.length; i++) {
    
//    text(personcount, 100, 100);
    
//}

//****************** Pixel Silhouette START ****************

 //// Grid determining increment at which to read pixel data
  int gridSize = 3;
  
  //// Loading pixels
  video.read();
  video.loadPixels();
  
  ////// Looping through each pixel reading
  for (int y = 0; y < video.height; y += gridSize) {
    for (int x = 0; x < video.width; x += gridSize) {
      // Formula for getting red value
      int index = (y * video.width + x);
      
  //    // Assigning RGB colour variables
      int pixelColor = video.pixels[index];
      int r = (pixelColor >> 16) & 0xFF;
  //    //int g = (pixelColor >> 8) & 0xFF;
  //    //int b = pixelColor & 0xFF;
      
  //   // println(r);
  //    println(g);
  //   // println(b);
      
      if (r <= 140
  //   // g <= 180 && b <= 180
     ) {
  //      // Any value above this RGB threshold is pretty white, meaning it is the background (ceiling)
        
        rect(x, y, 3, 3);  
  //      // Drawing a black pixel at the coordinates that are not white like the ceiling, 
  //         meaning they are objects/people that I want to display as a shadow
        tint(255, 150);  
        //applying transparency
      }
    }
  }
//****************** Pixel Silhouette END *************** 
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

void zeroP(){
  fencecircle.stop();
}

void oneP(){
 fencecircle.play();
    fencecircle.speed(1.0);
}

void twoP(){
   fencecircle.speed(2.0);
}

void threeP(){
  fencecircle.speed(4.0);
}

void fourP(){
   fencecircle.speed(8.0);
}


  
  
  
  
