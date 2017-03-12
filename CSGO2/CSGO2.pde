int x1=280, y1=100; //<>// //<>// //<>// //<>//
int x2=1000, y2=100;
int x3=280, y3=400;
int x4=1000, y4=400;
int crosshairWidth = 20;
int test = 0;
int Y = 50, X = 100;

void setup()
{
  size(1600, 900);  //galima bet kokia naudoti
  frameRate(60);
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

  line(0, height, x3, y3);
  line(width, height, x4, y4);
  line(x3, y3, x4, y4);
  line(x1, y1, x3, y3);
  line(x2, y2, x4, y4);

  //lubos
  if ((y1+y2)/2-1 >= 0) {
    if ((x1+x2)/2 >=0 && (x1+x2)/2 < width) {
      floodFill((x1+x2)/2, (y1+y2)/2-1, color(255), color(200));
    } else if (x1 < 0 && x2 > 0 && x2 < width) {
      floodFill(x2-1, (y1+y2)/2-1, color(255), color(200));
    } else if (x2 > width && x1 >= 0 && x1 < width) {
      floodFill(x1+1, (y1+y2)/2-1, color(255), color(200));
    } else if (x1 < 0 && x2 < 0 && y1 > 1 && y2 > 1) {
      floodFill(1, 1, color(255), color(200));
    } else if (x1 > width && x2 > width && y1 > 1 && y2 > 1) {
      floodFill(width-1, 1, color(255), color(200));
    }
  }

  //"Gun"
  stroke(0, 0, 0);
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

<<<<<<< HEAD

=======
>>>>>>> floodFillTest
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
}

void keyPressed()
{
  if (key=='w')
  {
    x1=x1-20;
  }
}

// ideja: https://en.wikipedia.org/wiki/Flood_fill
void floodFill (int x, int y, color what, color with)   //uzpildyti ekrano dali spalva
{
  if (x >= 0 && y >= 0) {
    if (what == with) return;
    loadPixels();    //isidedu ekrana i atminti (pixels[])
    //   vieta masyve = Y*width+X, kur X, Y - koordinates ekrane
    if (pixels[y*width+x] == with) {   // jei pradiniu koordinaciu spalva lygi pildomai spalvai
      return;   // baigti funkcija
    }
    if (pixels[y*width+x] != what) {   // jei pradiniu koordinaciu spalva nelygi uzpildomai spalvai
      return;
    }

    int stack[] = new int [width*height];
    stack[0] = y*width+x; 
    int stackCount = 1;

    while (stackCount > 0) {
      pixels[stack[0]] = with;
      if (stack[0] > 0) {
        if ((stack[0] - 1) % width != 0 && pixels[stack[0] - 1] == what) {
          pixels[stack[0] - 1] = with;
          stack[stackCount] = stack[0] - 1;
          stackCount++;
        }
      }
      if (stack[0] < width*(height-1)) {
        if (pixels[stack[0] + width] == what) {
          pixels[stack[0] + width] = with;
          stack[stackCount] = stack[0] + width;
          stackCount++;
        }
      }
      if (stack[0] < width*height - 1) {
        if ((stack[0] + 1) % width != 0 && pixels[stack[0] + 1] == what) {
          pixels[stack[0] + 1] = with;
          stack[stackCount] = stack[0] + 1;
          stackCount++;
        }
      }
      if (stack[0] >= width) {
        if (pixels[stack[0] - width] == what) {
          pixels[stack[0] - width] = with;
          stack[stackCount] = stack[0] - width;
          stackCount++;
        }
      }
      for (int i = 1; i < stackCount; i++) {
        stack[i-1] = stack[i];
      }
      stackCount--;
    }
    updatePixels();
  }
}
