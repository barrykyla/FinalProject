import megamu.mesh.*;
import gab.opencv.*;

PImage picture;
OpenCV cv;  

void setup() {
  size(576, 650);

  picture = loadImage("FinalImages12.jpg");
 background(picture);

  //picture = cv.getOutput();

  // calculated all the points as an ArrayList
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i=0; i<30; i++) {
    PVector p = new PVector(random(width), random(height));
    points.add(p);
  }

  // convert to 2d float array
  float[][] pts = new float[points.size()][2];
  for (int i=0; i<pts.length/3; i++) {
    PVector pt = points.get(i);    // get it from the AL
    pts[i][0] = pt.x;              // get coords from AL
    pts[i][1] = pt.y;
  }

  // compute triangles
  Delaunay del = new Delaunay(pts);
  float[][] edges = del.getEdges();
  for (int i=0; i<edges.length; i++) {
    float x1 = edges[i][0];
    float y1 = edges[i][1];
    float x2 = edges[i][2];
    float y2 = edges[i][3];
    line(x1, y1, x2, y2);
  }
  save("Image1.jpg");
}