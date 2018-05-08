import gab.opencv.*;
OpenCV cv;  
PImage picture, maskImage;
int numPoints = 20;
ArrayList<Contour> blobs;

void setup() {
  size(576, 650);
  background(221,212,215);

  picture = loadImage("Image4.jpg");
  PImage img = loadImage("Image4.jpg");
  //maskImage = loadImage("FinalIMages11 copy.jpg");
 

  cv = new OpenCV(this, picture);

  // blank list
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  //
  

  // opencv processing

  cv.invert();
  cv.threshold(40);
  cv.dilate();
  cv.erode();
 



  PImage mask = cv.getOutput();
  mask.filter(INVERT);
  img.mask(mask);
  image(img,0,0);
  //image(cv.getOutput(), 0,0);
  

  // cv blob detection
  // add outside edge points
  blobs = cv.findContours();
  for (Contour blob : blobs) {
    beginShape();
    for (PVector pt : blob.getPolygonApproximation().getPoints()) {
      points.add(pt);
    }
    endShape(CLOSE);
  }


  // create rando pts inside blob


  // points.add(randoPt) etc etc


  float distThresh = 288;

  for (PVector p1 : points) {
    for (PVector p2 : points) {
      for (PVector p3 : points) {
        if (p1.x == p2.x || p1.x == p3.x || p2.x == p3.x || p1.y == p2.y || p1.y == p3.y || p2.y == p3.y) {
          continue;
        }
        float d1_2 = PVector.dist(p1, p2);
        float d2_3 = PVector.dist(p2, p3);
        float d1_3 = PVector.dist(p1, p3);
        if (d1_2 > distThresh || d2_3 > distThresh || d1_3 > distThresh) {
          continue;
        }
        int x = int( (p1.x+p2.x+p3.x)/3 );
        int y = int( (p1.y+p2.y+p3.y)/3 );
        fill(picture.get(x,y),25);
        //fill(random(255), random(255), random(255));
        noStroke();
        triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
      }
    }
  }
  save("Image1.jpg");
}