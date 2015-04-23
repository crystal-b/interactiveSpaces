import gab.opencv.*;
import processing.video.*;
//what is this?
import java.awt.Rectangle;

Capture video;
PImage src, dst;
OpenCV opencv;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

PImage[] outputs;

void setup() {
  //size(640, 480);
  video = new Capture(this, 640, 480);
  //size(src.width, src.height/2);
  opencv = new OpenCV(this, video.width, video.height);
  size(opencv.width, opencv.height/2);
  video.start();
  //src = loadImage("test.jpg"); 
  
  println(opencv.width);
  println(opencv.height/2);
  println(video.width);
  println(video.height);
  
  
  //video.start();
  
/*
  opencv.gray();
  opencv.threshold(1000);
  dst = opencv.getOutput();

  contours = opencv.findContours();
  println("found " + contours.size() + " contours");
  
*/
}

void draw() {
  /*
  image(video, 0, 0);
  opencv.loadImage(video);
  opencv.gray();
  opencv.threshold(100);
    */
  
  contours = opencv.findContours();
  println("found" + contours.size() + "contours");

  
  if (video.available()) {
    video.read();
  }
  /*
  image(video, 0, 0);
  opencv.gray();
  opencv.threshold(1000);
  dst = opencv.getOutput();

  contours = opencv.findContours();
  println("found " + contours.size() + " contours");
  scale(0.5);
  if (video.available()) {
    video.read();
  }
  opencv.loadImage(video);
  src = opencv.getSnapshot();
  image(src, 0, 0);
  image(dst, src.width, 0);
  */

  noFill();
  strokeWeight(3);
  
  for (Contour contour : contours) {
    stroke(0, 255, 0);
    contour.draw();
    
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
  }
}
