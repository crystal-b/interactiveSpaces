import org.openkinect.*;
import org.openkinect.processing.*;
import gab.opencv.*;
import java.awt.Rectangle;
OpenCV opencv;


Kinect kinect;
int kWidth  = 640;
int kHeight = 480;
int kAngle  =  15;

PImage depthImg;
int minDepth =  60;
int maxDepth = 860;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;
void setup() {
  size(kWidth, kHeight);

  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);
  kinect.tilt(kAngle);
opencv = new OpenCV(this, kWidth, kHeight); 
  depthImg = new PImage(kWidth, kHeight);
}

void draw() {
  // threshold the depth image
  int[] rawDepth = kinect.getRawDepth();
  for (int i=0; i < kWidth*kHeight; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = 0xFFFFFFFF;
    } else {
      depthImg.pixels[i] = 0;
    }
  }

  // draw the thresholded image
  depthImg.updatePixels();
  // kinect.rgbImage;
image(depthImg, 0, 0);
  opencv.loadImage(depthImg);
  opencv.gray();
  opencv.threshold(150);
  
  contours = opencv.findContours();
  println("found" + contours.size() + "contours");
  
  noFill();
  strokeWeight(3);
  
  for (Contour contour : contours) {
    stroke(0, 255, 0);
    // contour.draw();
    
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
  }

}

void stop() {
  kinect.quit();
  super.stop();
}
