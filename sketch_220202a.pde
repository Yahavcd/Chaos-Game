import peasy.*;

PeasyCam cam;

boolean startFlag = false;
boolean flag3D = false;
boolean repFlag = false;
boolean doneFlag = false;

int textFlag = 0;
int drawMode = 0;
int pointsAmnt = 0;
int textR = 50;
int textL = 100;

int runI = 0;
int runJ = 0;
int runK = 0;

PVector[][] globe;
PVector[][] colo;
PVector[] pts;
PVector[] Cpts;
int total = 400;
int r = 200;

void setup() {
  size(600, 600, P3D);
  globe = new PVector[total+1][total+1];
  colo = new PVector[total+1][total+1];
  Cpts = new PVector[10];
  
  Cpts[0] = new PVector(255,0,0);
  Cpts[1] = new PVector(0,255,0);
  Cpts[2] = new PVector(0,0,255);
  Cpts[3] = new PVector(150,150,0);
  Cpts[4] = new PVector(150,0,150);
  Cpts[5] = new PVector(0,150,150);
  Cpts[6] = new PVector(150,150,150);
  Cpts[7] = new PVector(100,200,50);
  Cpts[8] = new PVector(50,100,200);
  Cpts[9] = new PVector(33,125,15);
}

void draw() {
  int i;
  background(0);
  stroke(255);
  if (textFlag >= 0 || textFlag <= 4) 
    startText(textFlag);
  if (doneFlag == true && drawMode != 4){
    for (i = 0; i < total+1; i++) { //<>//
      for (int j = 0; j < total+1; j++) {
        stroke(colo[i][j].x,colo[i][j].y,colo[i][j].z);
        point(globe[i][j].x,globe[i][j].y,globe[i][j].z);
      }
    }
  }
  else if (doneFlag == true){
    for ( i = 0; i < r; i++) {
      for (int j = 0; j < r; j++) {
        stroke(255,0,0);
        point(globe[i][j].x,globe[i][j].y,globe[i][j].z);
        }
      }
  }
}

void startText(int stage){
  
  textSize(25);
  
  if (stage == 0){
    text("Please choose a mode:", textR, textL);
    text("-Chaos Game: 1", textR+25, textL+50);
    text("-Bonus: Muare: 2", textR+25, textL+100);
  }
   else if (stage == 1){
    text("Please choose a mode:",textR, textL);
    text("-2D: 1", textR+25, textL+50);
    text("-3D: 2", textR+25, textL+100);
   }

    else if (stage == 2){
    text("Type the amount of points in space: ", textR, textL);
   }
    else if (stage == 3){
    text("Please choose a mode:", textR, textL);
    text("-Same point can be chosen twice in a row: 1", textR+25, textL+50);
    text("-Same point cant be chosen twice in a row: 2", textR+25, textL+100);
   }
    else if (stage == 4){
    text("Please choose a mode:", textR, textL);
    text("-Sperical: 1", textR+25, textL+50);
    text("-Euclidian: 2", textR+25, textL+100);
   }
}

void keyPressed() {
  if (key == '1'){
    if (textFlag == 0){
      textFlag = 1;
    }
    else if (textFlag == 1){
      textFlag = 2;
      flag3D = false;
      drawMode = 2;
    }
    else if (textFlag == 3){
      repFlag = true;
      textFlag = 5;
      startRun();
    }
    else if (textFlag == 4){
      textFlag = 2;
      drawMode = 1;
    }
  }
  
  else if (key == '2') {
     if (textFlag == 0){
       textFlag = 6;
       drawMode = 4;
       startRun();
     }
     else if (textFlag == 1){
      textFlag = 4;
      drawMode = 1;
      flag3D = true;
      }
     else if (textFlag == 4){
      textFlag = 2;
      drawMode = 3;
      }
     else if (textFlag == 3){
      repFlag = false;
      textFlag = 5;
      startRun();
      }  
  }
  else if ((key > '2' || key <= '9' || key == '0') && textFlag == 2){
    textFlag = 3;
    pointsAmnt = int(key - '0');
    if (pointsAmnt == 0)
      pointsAmnt = 10;
    pts = new PVector[pointsAmnt];
    if (flag3D == false)
    {
      pinPoint2D();
    }
    else
    {
      pinPoint3D();
    }
  }
  else if (key == 'r'){
      if(doneFlag != false){
        textR = -200;
        textL = -200;
      }
    startFlag = false;
    flag3D = false;
    repFlag = false;
    doneFlag = false;
    textFlag = 0;
    drawMode = 0;
    pointsAmnt = 0;
    startText(textFlag);
  }

}

void pinPoint2D(){
  int i = 0;
  while (i < pointsAmnt){
  pts[i] = new PVector(cos(TWO_PI/pointsAmnt * (i+1)) * r,(sin(TWO_PI/pointsAmnt * (i+1))) * r,0);
  i++;
  }
}

void pinPoint3D(){
  int i = 0;
  float x,y,z,l;
  
  while (i < pointsAmnt){
    if (i == 0)
      pts[0] = new PVector(r,0,0);
    else if (i == 1)
      pts[1] = new PVector(-r,0,0);
    else if (i == 2)
      pts[2] = new PVector(0,r,0);
    else if (i == 3)
      pts[3] = new PVector(0,0,r);
    else if (i == 4)
      pts[4] = new PVector(0,0,-r);
    else if (i == 5)
      pts[5] = new PVector(0,-r,0);
    else if (i == 6){
      x = (pts[0].x + pts[2].x)/2.;
      y = (pts[0].y + pts[2].y)/2.;
      z = (pts[0].z + pts[2].z)/2.;
      l = sqrt((x * x) + (y * y) + (z * z));
      pts[6] = new PVector(r*x/l,r*y/l,r*z/l);
    }
    else if (i == 7){
      x = (pts[2].x + pts[1].x)/2.;
      y = (pts[2].y + pts[1].y)/2.;
      z = (pts[2].z + pts[1].z)/2.;
      l = sqrt((x * x) + (y * y) + (z * z));
      pts[7] = new PVector(r*x/l,r*y/l,r*z/l);
    }
    else if (i == 8){
      x = (pts[1].x + pts[5].x)/2.;
      y = (pts[1].y + pts[5].y)/2.;
      z = (pts[1].z + pts[5].z)/2.;
      l = sqrt((x * x) + (y * y) + (z * z));
      pts[8] = new PVector(r*x/l,r*y/l,r*z/l);
    }
    else{
      x = (pts[5].x + pts[0].x)/2.;
      y = (pts[5].y + pts[0].y)/2.;
      z = (pts[0].z + pts[0].z)/2.;
      l = sqrt((x * x) + (y * y) + (z * z));
      pts[9] = new PVector(r*x/l,r*y/l,r*z/l);
    }
    i++;
  }
}

void startRun(){
   cam = new PeasyCam(this, 500);
   if (drawMode == 1)
     chaosSphr();
   if (drawMode == 2)
     chaos2D();
   if (drawMode == 3)
     chaos3D();
   if (drawMode == 4)
     muare();
}

void chaos2D(){
  float rand = random(0,PI);
  float x = r * cos(rand);
  float y = r * sin(rand);

  int i,j,chkPt,repPt = -1;
  
  
  for (i = 0; i < total+1; i++) {
    for (j = 0; j < total+1; j++) {
      chkPt = int(random(0,pointsAmnt));
      if(repFlag == false){
        while (repPt == chkPt)
          chkPt = int(random(0,pointsAmnt));
      }
      globe[i][j] = new PVector((x+pts[chkPt].x)/2, (y+pts[chkPt].y)/2, 0);
      x = globe[i][j].x;
      y = globe[i][j].y;
      colo[i][j] = Cpts[chkPt];
      repPt = chkPt;
    }
  }
    doneFlag = true;
}

void muare(){
  float x = 0;
  float y = 0;
  int i,j = 0;
  
  for (i = 0; i < r; i++) {
    for (j = 0; j < r; j++) {
        
        globe[i][j] = new PVector(x, y, 0);
        colo[i][j] = new PVector (255,0,0);
        x = i;
        y = j;
    }
  }
  doneFlag = true;
}

void chaos3D(){
  float lat = random(0,PI);
  float lon = random(0,TWO_PI);
  float x = r * sin(lat) * cos(lon);
  float y = r * sin(lat) * sin(lon);
  float z = r * cos(lat);

  int i,j,chkPt,repPt = -1;
  
  
  for (i = 0; i < total+1; i++) {
    for (j = 0; j < total+1; j++) {
      chkPt = int(random(0,pointsAmnt));
      if(repFlag == false){
        while (repPt == chkPt)
          chkPt = int(random(0,pointsAmnt));
      }
      globe[i][j] = new PVector((x+pts[chkPt].x)/2, (y+pts[chkPt].y)/2, (z+pts[chkPt].z)/2);
      x = globe[i][j].x;
      y = globe[i][j].y;
      z = globe[i][j].z;
      colo[i][j] = Cpts[chkPt];
      repPt = chkPt;
    }
  }
    doneFlag = true;
}

void chaosSphr(){
  float lat = random(0,PI);
  float lon = random(0,TWO_PI);
  float x = r * sin(lat) * cos(lon);
  float y = r * sin(lat) * sin(lon);
  float z = r * cos(lat);
  float l;
  int i,j,chkPt,repPt = -1;
  
  
  for (i = 0; i < total+1; i++) {
    for (j = 0; j < total+1; j++) {
      chkPt = int(random(0,pointsAmnt));
      if(repFlag == false){
        while (repPt == chkPt)
          chkPt = int(random(0,pointsAmnt));
      }
      
      x = (x + pts[chkPt].x)/2.;
      y = (y + pts[chkPt].y)/2.;
      z = (z + pts[chkPt].z)/2.;
      l = sqrt((x * x) + (y * y) + (z * z));
      
      globe[i][j] = new PVector(r*x/l,r*y/l,r*z/l);
      
      x = globe[i][j].x;
      y = globe[i][j].y;
      z = globe[i][j].z;
      colo[i][j] = Cpts[chkPt];
      repPt = chkPt;
    }
  }
    doneFlag = true;
}
