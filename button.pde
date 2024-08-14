class button {
  int circleX, circleY;  // Position of circle button
  int circleSize;   // Diameter of circle
  color circleColor, circleBasic;
  color circleHighlight;
  String circleName;
  
button(int iniCircleX, int iniCircleY, int iniCircleSize, color iniCircleColor, color iniCircleHighlight, String iniCircleName) {
  circleX = iniCircleX;
  circleY = iniCircleY;
  circleSize = iniCircleSize;
  circleColor = iniCircleColor;
  circleBasic = iniCircleColor;
  circleHighlight = iniCircleHighlight;
  circleName = iniCircleName;
}

void display() {
  fill(circleColor);
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
  
  textFont(f);
  fill(0);
  textAlign(CENTER);
  text(circleName, circleX, circleY);
}

boolean overCircle(int x, int y, int diameter) {
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
       if (circleColor == circleHighlight) {
        circleColor = circleBasic; 
        class_behaviour_stop();
        return false;
      }
      if (circleColor == circleBasic) {
        circleColor = circleHighlight;
        class_behaviour_start();
        return true;
      }
     }
     return false;
}
void class_behaviour_start() {
     attract = true;
}

void class_behaviour_stop() {
     attract = false;
}

}

class drawLines_button extends button {
  drawLines_button(int iniCircleX, int iniCircleY, int iniCircleSize, color iniCircleColor, color iniCircleHighlight, String iniCircleName) {
    super(iniCircleX,iniCircleY,iniCircleSize,iniCircleColor,iniCircleHighlight,iniCircleName);
  }
  void class_behaviour_start() {
     drawLines = true;
  }

  void class_behaviour_stop() {
     drawLines = false;
  }
}

class smallCircle_button extends button {
  smallCircle_button(int iniCircleX, int iniCircleY, int iniCircleSize, color iniCircleColor, color iniCircleHighlight, String iniCircleName) {
    super(iniCircleX,iniCircleY,iniCircleSize,iniCircleColor,iniCircleHighlight,iniCircleName);
  }
  void class_behaviour_start() {
     for (nemoc ne : nemoci) {
      ne.circleSize = 5;
      ne.textOffset = 24;
    }
     for (antigen an : antigeny) {
      an.circleSize = 5;
      an.textOffset = 24;
    }
  }

  void class_behaviour_stop() {
      for (nemoc ne : nemoci) {
      ne.circleSize = 80;
      ne.textOffset = 0;
    }
     for (antigen an : antigeny) {
      an.circleSize = 80;
      an.textOffset = 0;
    }
  }
}

class randomPlus_button extends button {
  randomPlus_button(int iniCircleX, int iniCircleY, int iniCircleSize, color iniCircleColor, color iniCircleHighlight, String iniCircleName) {
    super(iniCircleX,iniCircleY,iniCircleSize,iniCircleColor,iniCircleHighlight,iniCircleName);
  }
  
void display() {
  fill(circleColor);
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
  
  textFont(f);
  fill(0);
  textAlign(CENTER);
  text(circleName, circleX, circleY);
  text(randomSize, circleX-(circleSize/2+20), circleY+50);
}

boolean clicked() {
    if ( overCircle(circleX, circleY, circleSize)) {
        class_behaviour_start();
        return true;
      }
     return false;
}

void class_behaviour_start() {
      randomSize += 0.25;
    }
}

class randomMinus_button extends button {
  randomMinus_button(int iniCircleX, int iniCircleY, int iniCircleSize, color iniCircleColor, color iniCircleHighlight, String iniCircleName) {
    super(iniCircleX,iniCircleY,iniCircleSize,iniCircleColor,iniCircleHighlight,iniCircleName);
  }

boolean clicked() {
    if ( overCircle(circleX, circleY, circleSize)) {
        class_behaviour_start();
        return true;
      }
     return false;
}

void class_behaviour_start() {
     if (randomSize > 0) {
      randomSize -= 0.25;
    }
  }
}

class draggable_button extends button {
  draggable_button(int iniCircleX, int iniCircleY, int iniCircleSize, color iniCircleColor, color iniCircleHighlight, String iniCircleName) {
    super(iniCircleX,iniCircleY,iniCircleSize,iniCircleColor,iniCircleHighlight,iniCircleName);
  }
  void class_behaviour_start() {
     draggable = true;
  }

  void class_behaviour_stop() {
     draggable = false;
  }
}
