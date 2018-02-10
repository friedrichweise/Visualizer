import ddf.minim.*;

Minim minim;
float currentRun = 0;
Scene activeScene;
AudioSource currentAudioSource = new AudioSource();
//defines the ratio between display width and equalizer buffer window
private int windowScale = 2;

void setup()
{
	fullScreen(SPAN);
	surface.setTitle("Visualizer");
	surface.setResizable(true);

	minim = new Minim(this);
	//activate main menu
	enableScene("mainmenu");
}


void keyPressed() {
	//play from file selected, opening file input
	if (key=='1') {
		selectInput("Select a file to process:", "fileSelected");
	} else if (key=='2') {
		//use system lineIn input
		initLineIn();
	} else if (key=='b') {
		enableScene("mainmenu");		
	}
	//fallback for scenes with keyboard support
	activeScene.reactToKeyboardInput(key);
}

void fileSelected(File selection) {
	if (selection == null) {
		println("Window was closed or the user hit cancel.");
	} else {
		initFilePlay(selection.getAbsolutePath());
	}
}

void initFilePlay(String audioFilePath) {
	AudioPlayer player;
	player = minim.loadFile(audioFilePath, width/windowScale);
	currentAudioSource.useAudioPlayer(player);
	player.play(0);
	println("Init AudioPlayer with buffer size: ", width/windowScale);
	enableScene("waveform");
}

void initLineIn() {
	AudioInput input;
	input = minim.getLineIn(Minim.STEREO, width/windowScale);
	currentAudioSource.useAudioInput(input);
	enableScene("waveform");
}

//@todo: move to own scene manager
void enableScene(String sceneIdentifier) {
	if(sceneIdentifier == "mainmenu") {
		activeScene = new MainMenu("Main menu scene");
	} else if(sceneIdentifier == "waveform") {
		activeScene = new SimpleWaveform("First Simple Waveform Scene");
	}
}

void draw()
{
	background(0);
	activeScene.drawScene(currentRun);
	currentRun += 0.005;
	if (currentRun == 10) currentRun = 0;
	delay(40);
}
