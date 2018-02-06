import ddf.minim.*;

Minim minim;
Scene[] activeScenes;

void setup()
{
	size(800, 200);
	surface.setTitle("Visualizer");
	surface.setResizable(true);
	minim = new Minim(this);
	selectInput("Select a file to play", "fileSelected");
}
String audioFilePath = "";
void fileSelected(File selection) {
	if (selection == null) {
		println("Window was closed or the user hit cancel.");
	} else {
		audioFilePath = selection.getAbsolutePath();
	}
}
boolean running = false;
AudioSource currentAudioSource = new AudioSource();

void keyPressed() {
	//@todo: run the reactToKeyboardInput() function on all active scenes
	if (key=='1') {
		pausePlayButtonClicked();
	} else if (key=='2') {
		lineInInputSelected();
	} if (key=='b') {
		running=true;
	}
}
//scales our frame window from window width
int windowScale = 2;
void pausePlayButtonClicked() {
	prepareDraw();
	AudioPlayer player;
	player = minim.loadFile(audioFilePath, width/windowScale);
	currentAudioSource.useAudioPlayer(player);
	player.play(0);
}
	
void lineInInputSelected() {
	AudioInput input;
	input = minim.getLineIn(Minim.STEREO, width/windowScale);
	currentAudioSource.useAudioInput(input);
}


int currentRun = 0;
void draw()
{
	//@todo: draw all active scenes
	background(0);
	if (running) {
		drawWaveform();
	} else {
		drawMainMenu();
	}
	currentRun++;
	if (currentRun == 3000) currentRun = 0;
	delay(20);
}