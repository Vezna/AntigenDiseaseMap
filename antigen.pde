class antigen {
float circleX, circleY;  // Position of circle button
int circleSize;   // Diameter of circle
color circleColor, circleBasic;
color circleHighlight;
String circleName;
IntList foundPartners;
float partnerX, partnerY;
float xVelocity, yVelocity, xFactor;
int xVector, yVector;
int textOffset = 0;
boolean setForDrag = false;



//constructor
antigen(int iniCircleX, int iniCircleY, int iniCircleSize, color iniCircleColor, color iniCircleHighlight, String iniCircleName) {
  circleX = iniCircleX;
  circleY = iniCircleY;
  circleSize = iniCircleSize;
  circleColor = iniCircleColor;
  circleBasic = iniCircleColor;
  circleHighlight = iniCircleHighlight;
  circleName = iniCircleName;
  foundPartners = new IntList();
}

void display() {
  fill(circleColor);
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
  
  textFont(f);
  fill(255,80);
  textAlign(CENTER);
  text(circleName, circleX+1+textOffset, circleY+1-textOffset/2);
  fill(0,255);
  text(circleName, circleX+textOffset, circleY-textOffset/2);
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
  if ( overCircle(circleX, circleY, circleSize)) {
    circleColor = circleHighlight;
    class_behaviour_start();
    return true;
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
String report_name() {
  return circleName;
}

void tag_partners() {
  for (int partnernum : foundPartners) {
  nemoc ne = nemoci.get(partnernum);
  ne.tagged();
  }
}

void detag_partners() {
  for (int partnernum : foundPartners) {
  nemoc ne = nemoci.get(partnernum);
  ne.detagged();
  }
}

void tagged() {
  circleColor = circleHighlight;
}

void detagged() {
  circleColor = circleBasic;
}

void save_friendship(int nemocNum) {
  foundPartners.append(nemocNum);
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

void attract_partner() {
  float divider = 1920;
  for (int partnernum : foundPartners) {
    nemoc ne = nemoci.get(partnernum);
    partnerX = ne.reportX();
    partnerY = ne.reportY();
    if (circleX == partnerX) {
      xVelocity = 0;
  }
    else {
      xVector = int((circleX - partnerX)/abs((circleX - partnerX)));
      xFactor = sq(circleX - partnerX)/(sq(circleX - partnerX)+sq(circleY - partnerY));
      xVelocity = xVector * 192 * sq((circleX - partnerX)/divider);
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
      yVelocity = yVector * 192 * sq((circleY - partnerY)/divider);
      if (abs(yVelocity) > 50) {
        yVelocity = yVector * 50;
      }
      if (abs(yVelocity) < 0.1) {
        yVelocity = 0;
      }
    }
    circleX = circleX - xVelocity  + random(-randomSize, randomSize);
    circleY = circleY - yVelocity  + random(-randomSize, randomSize);
  }
}

void repulse_everyone() {
  float divider = 20000;
  for (antigen an : antigeny) {
    partnerX = an.reportX();
    partnerY = an.reportY();
    if (circleX == partnerX) {
      xVelocity = 0;
  }
    else {
      xVector = int((circleX - partnerX)/abs((circleX - partnerX)));
      xFactor = sq(circleX - partnerX)/(sq(circleX - partnerX)+sq(circleY - partnerY));
      xVelocity = (xFactor * 50000 * xVector)/(divider+2*sq(circleX - partnerX));
      if (abs(xVelocity) > 10) {
        xVelocity = 10;
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
      yVelocity = ((1-xFactor)*50000*yVector)/(divider+2*sq(circleY - partnerY));
      if (abs(yVelocity) > 10) {
        yVelocity = 10;
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
