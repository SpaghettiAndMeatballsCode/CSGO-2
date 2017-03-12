int x1=int(0.21875*width), y1=int(0.125*height); //<>//
int x2=int(0.78125*width), y2=int(0.125*height);
int x3=int(0.21875*width), y3=int(0.5*height);
int x4=int(0.78125*width), y4=int(0.5*height);
int crosshairWidth = 20;

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

  // lubos
  line(0, 0, x1, y1);
  line(width, 0, x2, y2);
  line(x1, y1, x2, y2);

  line(0, height, x3, y3);
  line(width, height, x4, y4);
  line(x3, y3, x4, y4);
  line(x1, y1, x3, y3);
  line(x2, y2, x4, y4);

  //lubu nuspalvinimas
  if (y1 > 0) {   // jei lubos ekrane
    if ((x1 > 0 && x1 < x2 && x2 <= width) || (x2 > width && x1 >= 0 && x1 < width)) {   // jei lubu krastai ekrane arba x2 uz ekrano desineje
      floodFill(x1+1, y1-1, color(255), color(200));  // pradedam nuo x1, y1
    } else if (x1 <= 0 && x2 > 0 && x2 < width) {  // jei x1 uz ekrano kaireje
      floodFill(x2-1, y2-1, color(255), color(200));  // pradedam nuo x2, y2
    } else if (x1 < 0 && x2 < 0 && y1 > 1 && y2 > 1) {  // jei abu uz ekrano kaireje
      floodFill(1, 1, color(255), color(200));   // pradedam nuo virsutinio kairio kampo
    } else if (x1 > width && x2 >= width && y1 > 1 && y2 > 1) {  // jei abu uz ekrano desineje
      floodFill(width-1, 1, color(255), color(200));  // pradedam nuo virsutinio desinio kampo
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
  
  float fov=0.33;    // iki 0.5
  int aimX=(width-(mouseX*2))/2;
  int aimY=(height-(mouseY*2))/2;
  
  x1=int(aimX+width*fov);
  x2=int(aimX+width*(1-fov));
  x3=int(aimX+width*fov);
  x4=int(aimX+width*(1-fov));

  y1=int(aimY+height*fov);
  y2=int(aimY+height*fov);
  y3=int(aimY+height*(1-fov));
  y4=int(aimY+height*(1-fov));
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
  if (what == with) return;  //jei spalva kuria pildom lygi spalvai, kurią pildom baigiam funkcija
  if (x >= 0 && y >= 0) {
    loadPixels();    //isidedu ekrana i atminti (pixels[])
    //   vieta masyve = Y*width+X, kur X, Y - koordinates ekrane
    
    if (pixels[y*width+x] == with)  return;   // jei pradiniu koordinaciu spalva lygi pildomai spalvai baigti funkcija
    if (pixels[y*width+x] != what) return;   // jei pradiniu koordinaciu spalva nelygi uzpildomai spalvai baigti funkcija

    int stack[] = new int [int(2*height*sqrt(2)+1)];   //vieta pildymo eilei
    stack[0] = y*width+x;   //pirmas narys
    int stackCount = 1;    // kiek eileje nariu
    pixels[stack[0]] = with;   // pakeiciam pirma pixeli

    while (stackCount > 0) {   //kol turim ka keist
      if (stack[0] > 0) {      //jei neiseinam uz masyvo ribu
        if ((stack[0] - 1) % width != 0 && pixels[stack[0] - 1] == what) {   //jei pikselis i kaire tinka
          pixels[stack[0] - 1] = with;              //pakeiciam ji
          stack[stackCount] = stack[0] - 1;        //pasiimam ji i eile
          stackCount++;                           //ir pridedam nari
        }
      }
      if (stack[0] < width*(height-1)) {        //jei neiseinam uz masyvo ribu
        if (pixels[stack[0] + width] == what) {   //jei pikselis i apacia tinka
          pixels[stack[0] + width] = with;
          stack[stackCount] = stack[0] + width;
          stackCount++;
        }
      }
      if (stack[0] < width*height - 1) {          //jei neiseinam uz masyvo ribu
        if ((stack[0] + 1) % width != 0 && pixels[stack[0] + 1] == what) {   //jei pikselis i desine tinka
          pixels[stack[0] + 1] = with;
          stack[stackCount] = stack[0] + 1;
          stackCount++;
        }
      }
      if (stack[0] >= width) {                   //jei neiseinam uz masyvo ribu
        if (pixels[stack[0] - width] == what) {   //jei pikselis i virsu tinka
          pixels[stack[0] - width] = with;
          stack[stackCount] = stack[0] - width;
          stackCount++;
        }
      }
      for (int i = 1; i < stackCount; i++) {    //ismetam jau panaudota ir pastumiam viska atgal
        stack[i-1] = stack[i];
      }
      stackCount--;
    }
    updatePixels();
  }
}