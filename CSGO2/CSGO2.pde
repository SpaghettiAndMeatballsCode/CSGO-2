int x1=280, y1=100;
int x2=1000, y2=100;
int x3=280, y3=400;
int x4=1000, y4=400;
int crosshairWidth = 20;
int test = 0;
int Y = 50, X = 100;

void setup()
{
  size(1024, 600);  //galima bet kokia naudoti
  frameRate(15);
  //noCursor();
}
void draw()
{
  background(255);
  fill(0, 0, 0);
  stroke(0, 0, 0);

  line(0, 0, x1, y1);
  line(width, 0, x2, y2);
  line(x1, y1, x2, y2);
  floodFill(5, 5, color(255, 255, 255), color(255, 0, 0));

  test = Y*width+X;
  loadPixels();
  /*while(test < width*height && pixels[test] == color(255, 255, 255)) {
   //loadPixels();
   pixels[test] = color(255, 150, 0);
   //println(test);
   //updatePixels();
   test++;
   }*/
  //println(test);
  test = Y*width+X;
  updatePixels();

  line(0, height, x3, y3);
  line(width, height, x4, y4);
  line(x3, y3, x4, y4);
  line(x1, y1, x3, y3);
  line(x2, y2, x4, y4);

  //"Gun"
  line(width-488, height-293, width-237, height-133);
  line(width-237, height-133, width-191, height-56);
  line(width-191, height-56, width-94, height);
  line(width-364, height-133, width-360, height);
  line(width-364, height-133, width-443, height);
  line(width-644, height, width-502, height-222);
  line(width-502, height-222, width-488, height-293);

  //crosshair
  stroke(0, 255, 0);
  line(width/2-crosshairWidth, height/2, width/2+crosshairWidth, height/2);
  line(width/2, height/2-crosshairWidth, width/2, height/2+crosshairWidth);


  int aimX=(width/2)-mouseX;
  int aimY=(height/2)-mouseY;
  x1=aimX;
  x2=aimX+720;
  x3=aimX;
  x4=aimX+720;


  y1=aimY;
  y2=aimY;
  y3=aimY+300;
  y4=aimY+300;
}

void mousePressed() {
  //floodFill(100, 1, color(255, 255, 255), color(255, 0, 0));
}

void keyPressed()
{

  if (key=='w')
  {
    x1=x1-20;
  }
  // if(key=='s')
  {
  }
}

void floodFill (int x, int y, color what, color with)   //uzpildyti ekrano dali spalva
{
  loadPixels();    //isidedu ekrana i atminti (pixels[])
  //   vieta masyve = Y*width+X, kur X, Y - koordinates ekrane
  if (pixels[y*width+x] == with) {   // jei pradiniu koordinaciu spalva lygi pildomai spalvai
    return;   // baigti funkcija
  }
  if (pixels[y*width+x] != what) {   // jei pradiniu koordinaciu spalva nelygi uzpildomai spalvai
    return;
  }

  int queueSize = 0;
  int queue[] = new int [width*height];

  if (y*width+x < width*height) {
    queue[0] = y*width+x;
    queueSize++;
  }

  while (queueSize > 0) {
    println(queueSize + " is " + pixels[queue[queueSize]] + " = " + what);
    if (pixels[queue[queueSize]] == what) {
      int w = queue[0], e = queue[0];
      while (pixels[w] == what && w > y*width) {
        w--;
      }

      while (pixels[e] == what && e < (y+1)*width) {
        e++;
      }
      for (int i = w; i <= e; i++) {
        pixels[i] = with;
        if (i >= width) {
          if (pixels[i-width] == what) {
            queue[queueSize] = i-width;
            queueSize++;
          }
        }
        if (i <= width*(height-1)) {
          if (pixels[i+width] == what) {
            queue[queueSize] = i+width;
            queueSize++;
          }
        }
      }
    }
    for (int i = 1; i < queueSize; i++) {
      queue[queueSize-1] = queue[queueSize];
    }
    queueSize--;
  }

  updatePixels();
}