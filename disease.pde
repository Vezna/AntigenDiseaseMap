class nemoc {
float circleX, circleY;  // Position of circle button
int circleSize;   // Diameter of circle
color circleColor, circleBasic;
color circleHighlight;
String circleName;
String[] antigensPositive;
IntList foundPartners;
int nemocNum;
float partnerX, partnerY;
float xVelocity, yVelocity, xFactor;
int xVector, yVector;
int textOffset = 0;
boolean setForDrag = false;

//constructor
nemoc  (String line) {
  String[] splitLine = split(line, ";");
  String[] color1Split = split(splitLine[4], ",");
  String[] color2Split = split(splitLine[5], ",");
  String[] nameSplit = split(splitLine[6], " ");

  circleX = float(splitLine[1]);
  circleY = float(splitLine[2]);
  circleSize = int(splitLine[3]);
  circleColor = color(int(color1Split[0]),int(color1Split[1]),int(color1Split[2]));
  circleBasic = color(int(color1Split[0]),int(color1Split[1]),int(color1Split[2]));
  circleHighlight = color(int(color2Split[0]),int(color2Split[1]),int(color2Split[2]));
  circleName = nameSplit[0] + "\n" + nameSplit[1];
  antigensPositive = split(splitLine[7], ",");
  foundPartners = new IntList();
  nemocNum = int(splitLine[0]);
}

void display() {
  fill(circleColor);
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
  
  textFont(f);
  fill(255,80);
  textAlign(CENTER);
  text(circleName, circleX+1+textOffset, circleY+1-textOffset);
  fill(0,255);
  text(circleName, circleX+textOffset, circleY-textOffset);
}

boolean overCircle(float x, float y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

boolean clicked() {
     if (circleColor == circleHighlight) {
        circleColor = circleBasic; 
        class_behaviour_stop();
        return false;
      }
    if ( overCircle(circleX, circleY, circleSize)) {
      if (circleColor == circleBasic) {
        circleColor = circleHighlight;
        class_behaviour_start();
        return true;
      }
     }
     return false;
}

boolean clicked_drag() {
  if (setForDrag) {
    circleX = mouseX;
    circleY = mouseY;
    return true;
  }
  if (!dragTargetFound) {
    if ( overCircle(circleX, circleY, 80)) {
      dragTargetFound = true;
      setForDrag = true;
      circleX = mouseX;
      circleY = mouseY;
      return true;
       }
  }
     return false;
}


void class_behaviour_start() {
     tag_partners();
}

void class_behaviour_stop() {
     detag_partners();
}

void find_friends() {
  String currentName;
  for (int i = 0; i < antigeny.size(); i++) {
    antigen an = antigeny.get(i);
    currentName = an.report_name();
    for (int j = 0; j < antigensPositive.length; j++) {
      if (currentName.equals(antigensPositive[j])) {
        foundPartners.append(i);
        an.save_friendship(nemocNum);
      }
    }
  }  
}

void tag_partners() {
  for (int partnernum : foundPartners) {
  antigen an = antigeny.get(partnernum);
  an.tagged();
  }
}

void detag_partners() {
  for (int partnernum : foundPartners) {
  antigen an = antigeny.get(partnernum);
  an.detagged();
  }
}

void tagged() {
  circleColor = circleHighlight;
}

void detagged() {
  circleColor = circleBasic;
}

float reportX() {
  return circleX;
}

float reportY() {
  return circleY;
}

void move() {
  attract_partner();
  repulse_everyone();
  bordercheck();
}

void draw_Lines() {
  strokeWeight(2);
  stroke(100);
  for (int partnernum : foundPartners) {
    antigen an = antigeny.get(partnernum);
    partnerX = an.reportX();
    partnerY = an.reportY();
    line(circleX, circleY, partnerX, partnerY);
  }
  strokeWeight(1);
  stroke(255);
}

void attract_partner() {
  for (int partnernum : foundPartners) {
    antigen an = antigeny.get(partnernum);
    partnerX = an.reportX();
    partnerY = an.reportY();
    if (circleX == partnerX) {
      xVelocity = 0;
  }
        else {
      xVector = int((circleX - partnerX)/abs((circleX - partnerX)));
      xFactor = sq(circleX - partnerX)/(sq(circleX - partnerX)+sq(circleY - partnerY));
//xVelocity = (xFactor * 100000 * xVector)/(divider+sq(circleX - partnerX))
      xVelocity = xVector * 192 * sq((circleX - partnerX)/1920);
      if (abs(xVelocity) > 50) {
        xVelocity = xVector * 50;
      }
      if (abs(xVelocity) < 0.1) {
        xVelocity = 0;
      }

      
    }
     if (circleY == partnerY) {
      yVelocity = 0;
  }
    else {
      yVector = int((circleY - partnerY)/abs((circleY - partnerY)));
//      yVelocity = ((1-xFactor)*100000*yVector)/(divider+sq(circleY - partnerY));
      yVelocity = yVector * 192 * sq((circleY - partnerY)/1920);
      if (abs(yVelocity) > 50) {
      yVelocity = yVector * 50;
      }
    }
    circleX = circleX - xVelocity  + random(-randomSize, randomSize);
    circleY = circleY - yVelocity  + random(-randomSize, randomSize);
  }
}

void repulse_everyone() {
  int divider = 20000;
  for (nemoc ne : nemoci) {
    partnerX = ne.reportX();
    partnerY = ne.reportY();
    if (circleX == partnerX) {
      xVelocity = 0;
  }
else {
      xVector = int((circleX - partnerX)/abs((circleX - partnerX)));
      xFactor = sq(circleX - partnerX)/(sq(circleX - partnerX)+sq(circleY - partnerY));
      xVelocity = (xFactor * 20000 * xVector)/(divider+2*sq(circleX - partnerX));
      if (abs(xVelocity) > 10) {
        xVelocity = xVector * 10;
      }
      if (abs(xVelocity) < 0.1) {
        xVelocity = 0;
      }

    }
    if (circleY == partnerY) {
      yVelocity = 0;
  }
    else {
      yVector = int((circleY - partnerY)/abs((circleY - partnerY)));
      yVelocity = ((1-xFactor)*20000*yVector)/(divider+2*sq(circleY - partnerY));
      if (abs(yVelocity) > 10) {
        yVelocity = yVector*10;
      }
    if (abs(yVelocity) < 0.1) {
        yVelocity = 0;
      }

    }
    circleX = circleX + xVelocity + random(-randomSize, randomSize);
    circleY = circleY + yVelocity + random(-randomSize, randomSize);
  }
}

void bordercheck() {
  if (circleX > 1885) {
    circleX = 1884;
  }
  if (circleX < 35) {
    circleX = 36;
  }
  if (circleY > 1045) {
    circleY = 1044;
  }
  if (circleY < 35) {
    circleY = 36;
  }
}

}
