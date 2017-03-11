int x=400;
int y=700;
int x1=280;
int y1=100;
int x2=1000;
int y2=100;
int x3=280;
int y3=400;
int x4=1000;
int y4=400;
int crosshairWidth = 20;
int taskai=80;

void setup()
{
  size(1600, 900);  //galima bet kokia naudoti (tik ginklas ne ten bus)
  frameRate(60);
  noCursor();
}
void draw()
{
  background(255);
  fill(0, 0, 0);
  stroke(0, 0, 0);
  line(0, 0, x1, y1);
  line(width, 0, x2, y2);
  line(0, height, x3, y3);
  line(width, height, x4, y4);
  line(x1, y1, x2, y2);
  line(x3, y3, x4, y4);
  line(x1, y1, x3, y3);
  line(x2, y2, x4, y4);

  //"Gun"
  line(792, 507, 1043, 667);
  line(1043, 667, 1089, 744);
  line(1089, 744, 1186, 800);
  line(916, 667, 920, 800);
  line(916, 667, 837, 800);
  line(636, 800, 778, 578);
  line(778, 578, 792, 507);

  //crosshair
  stroke(0, 255, 0);
  line(width/2-crosshairWidth, height/2, width/2+crosshairWidth, height/2);
  line(width/2, height/2-crosshairWidth, width/2, height/2+crosshairWidth);


  int aimX=640-mouseX;
  int aimY=400-mouseY;
  x1=aimX;
  x2=aimX+720;
  x3=aimX;
  x4=aimX+720;


  y1=aimY;
  y2=aimY;
  y3=aimY+300;
  y4=aimY+300;
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