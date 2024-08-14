PFont f;
color circleColor, baseColor;
color circleHighlight;
boolean circleOver = false;
ArrayList<nemoc> nemoci = new ArrayList<nemoc>();
ArrayList<antigen> antigeny = new ArrayList<antigen>();
ArrayList<button> buttons = new ArrayList<button>();
int frameLock = 0;
boolean attract = false;
boolean drawLines = false;
boolean clicker = false;
boolean draggable = false;
float randomSize = 0.5;
boolean dragTargetFound = false;

void setup() {

  size(1880, 980);

  antigeny.add(new antigen(100,100,80,color(120,120,120),color(160, 255, 0), "AChR"));
  antigeny.add(new antigen(100,200,80,color(120,120,120),color(160, 255, 0), "MuSK"));
  antigeny.add(new antigen(100,300,80,color(120,120,120),color(160, 255, 0), "Titin"));
  antigeny.add(new antigen(100,400,80,color(120,120,120),color(160, 255, 0), "GAD65"));
  antigeny.add(new antigen(100,500,80,color(120,120,120),color(160, 255, 0), "CV2"));
  antigeny.add(new antigen(200,100,80,color(120,120,120),color(160, 255, 0), "Hu"));
  antigeny.add(new antigen(200,200,80,color(120,120,120),color(160, 255, 0), "Yo"));
  antigeny.add(new antigen(200,300,80,color(120,120,120),color(160, 255, 0), "Ri"));
  antigeny.add(new antigen(200,400,80,color(120,120,120),color(160, 255, 0), "Tr"));
  antigeny.add(new antigen(200,500,80,color(120,120,120),color(160, 255, 0), "ZlC4"));
  antigeny.add(new antigen(300,100,80,color(180,180,180),color(160, 255, 0), "LPL4"));
  antigeny.add(new antigen(300,200,80,color(120,120,120),color(160, 255, 0), "MA2"));
  antigeny.add(new antigen(300,300,80,color(120,120,120),color(160, 255, 0), "AQP4"));
  antigeny.add(new antigen(300,400,80,color(120,120,120),color(160, 255, 0), "NMDAR"));
  antigeny.add(new antigen(300,500,80,color(120,120,120),color(160, 255, 0), "LGl1"));
  antigeny.add(new antigen(400,100,80,color(120,120,120),color(160, 255, 0), "Caspr2"));
  antigeny.add(new antigen(400,200,80,color(120,120,120),color(160, 255, 0), "Recoverin"));
  antigeny.add(new antigen(1000,100,80,color(120,120,120),color(160, 255, 0), "SOX1"));
  antigeny.add(new antigen(1000,200,80,color(120,120,120),color(160, 255, 0), "Amphiphysin"));
  antigeny.add(new antigen(1000,300,80,color(120,120,120),color(160, 255, 0), "MA1"));
  antigeny.add(new antigen(1000,400,80,color(180,180,180),color(160, 255, 0), "MOG"));
  antigeny.add(new antigen(1000,500,80,color(180,180,180),color(160, 255, 0), "MAG"));
  loadNemoci();
  buttons.add(new button(1800,60,60,color(100,100,100),color(160, 255, 0), "Play"));
  buttons.add(new drawLines_button(1800,140,60,color(100,100,100),color(160, 255, 0), "Draw \n lines"));
  buttons.add(new smallCircle_button(1800,220,60,color(100,100,100),color(160, 255, 0), "Small \n circles"));
  buttons.add(new randomPlus_button(1800,300,60,color(100,100,100),color(160, 255, 0), "Plus \n random"));
  buttons.add(new randomMinus_button(1800,380,60,color(100,100,100),color(160, 255, 0), "Minus \n random"));
  buttons.add(new draggable_button(1800,460,60,color(100,100,100),color(160, 255, 0), "Drag"));
  
  baseColor = color(220);
  ellipseMode(CENTER);
  f = createFont("Arial",14,true);
  
  for (nemoc ne : nemoci) {
    ne.find_friends();
  }
}

void draw() {
  background(baseColor);
  if (attract) {
    for (nemoc ne : nemoci) {
      ne.move();
    }
     for (antigen an : antigeny) {
      an.move();
    }
  }
  if (drawLines) {
    for (nemoc ne : nemoci) {
    ne.draw_Lines();
  }
    
  }
  
  for (antigen an : antigeny) {
    an.display();
  }
  for (nemoc ne : nemoci) {
    ne.display();
  }
  for (button bu : buttons) {
    bu.display();
  }
  drag_and_drop();

}

void drag_and_drop() {
  if (draggable) {
    if (mousePressed) {
      clicker = false;
        for (antigen an : antigeny) {
          clicker = an.clicked_drag();
          if (clicker) {
            break;
          }
        }
        if (!clicker) {
          for (nemoc ne : nemoci) {
            clicker = ne.clicked_drag();
            if (clicker) {
              break;
             }
           }
        }
      }
    }
  
}
void loadNemoci() {
  String[] lines = loadStrings("nemoci.txt");
  for (int i = 0 ; i < lines.length; i++) {
    nemoci.add(new nemoc(lines[i]));
  }
}

void mouseReleased() {
  clicker = false;
  dragTargetFound = false;
  if (draggable) {
    for (antigen an : antigeny) {
      an.setForDrag = false;
    }
    for (nemoc ne : nemoci) {
      ne.setForDrag = false;
    }
  }
  if (!draggable) {
    release_both_classes();
    for (antigen an : antigeny) {
      clicker = an.clicked();
      if (clicker) {
        break;
      }
    }
    if (!clicker) {
      for (nemoc ne : nemoci) {
        clicker = ne.clicked();
        if (clicker) {
          break;
       }
       }
    }
    }
    if (!clicker) {
      for (button bu : buttons) {
        clicker = bu.clicked();
        if (clicker) {
          break;
        }
      }
    }
}

void release_both_classes() {
  for (antigen an : antigeny) {
    an.circleColor = an.circleBasic;
    an.setForDrag = false;
    an.class_behaviour_stop();
  }
  for (nemoc ne : nemoci) {
    ne.circleColor = ne.circleBasic;
    ne.setForDrag = false;
    ne.class_behaviour_stop();
  }
}
