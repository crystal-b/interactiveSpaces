import org.openkinect.*;
import org.openkinect.processing.*;

Kinect kinect;
int kWidth  = 640;
int kHeight = 480;
int kAngle  =  15;

PImage depthImg;
int minDepth =  60;
int maxDepth = 860;

void setup() {
  size(kWidth, kHeight);

  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);
  kinect.tilt(kAngle);
 
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
}

void stop() {
  kinect.quit();
  super.stop();
}
