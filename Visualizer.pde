import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer song;
String audioFilePath = "";
void setup()
{
  size(1024, 200, P3D);
  frame.setTitle("Visualize"); 
  surface.setResizable(true);

  minim = new Minim(this);
  selectInput("Select a file to play", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    audioFilePath = selection.getAbsolutePath();
  }
}

boolean running = false;

void keyPressed() {
 if(key=='b') {
   pausePlayButtonClicked();
 }  
}
//scales our frame window from window width
int windowScale = 2;
void pausePlayButtonClicked() {
  if(running) {
    song.pause();
  } else {
   prepareDraw();
   song = minim.loadFile(audioFilePath, width/windowScale);
   song.play(0);
  }
  running = !running;
}

int yLine1;
int yLine2;

void prepareDraw() {
   //init routine
   yLine1 = Math.round(0.25 * height);
   yLine2 = Math.round(0.75 * height);
   colorMode(HSB, 100.0);
}
float runOffSet = 0.0;
float getCurrentHueForLine1(int step, int run) {
  runOffSet = (30.0*cos((run*0.01)+10)+60.0);
  return 10.0*cos(step*0.01)+runOffSet;
}
float getCurrentHueForLine2(int step, int run) {
  runOffSet = (30.0*cos(run*0.01)+60.0);
  return 10.0*cos(step*0.01)+runOffSet;
}

float getCurrentWidth(int step, int run) {
  return cos(step*0.03)+(2*cos(run*0.001)+3);
}

int lineScale = 100;
float colorSaturation = 20.0;
int currentRun = 0;
void draw()
{
  background(0);
  if(running) {
    for(int i = 0; i < song.bufferSize() - 1; i++)
    {
      strokeWeight(getCurrentWidth(i, currentRun));
      stroke(getCurrentHueForLine1(i,currentRun), colorSaturation, 80.0);
      line(i*windowScale, yLine1 + song.left.get(i)*lineScale, (i+1)*windowScale, yLine1 + song.left.get(i+1)*lineScale);
      stroke(getCurrentHueForLine2(i,currentRun), colorSaturation, 80.0);
      line(i*windowScale, yLine2 + song.right.get(i)*lineScale, (i+1)*windowScale, yLine2 + song.right.get(i+1)*lineScale);
    }
  }
  currentRun++;
  if(currentRun == 3000) currentRun = 0;
  delay(20);
}