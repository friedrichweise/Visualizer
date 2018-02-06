import ddf.minim.*;

Minim minim;
int currentRun = 0;
Scene activeScene;
AudioSource currentAudioSource = new AudioSource();
//defines the ratio between display width and equalizer buffer window
private int windowScale = 2;

void setup()
{
	fullScreen();
	surface.setTitle("Visualizer");
	surface.setResizable(true);
	minim = new Minim(this);

	MainMenu menu = new MainMenu("Main menu scene");
	activeScene = menu;
}


void keyPressed() {
	println("Key pushed: ", key);
	//play from file selected, opening file input
	if (key=='1') {
		selectInput("Select a file to process:", "fileSelected");
	} else if (key=='2') {
	//use system lineIn input
		initLineIn();
	} else if (key=='b') {
		MainMenu menu = new MainMenu("Main menu scene");
		activeScene = menu;		
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
	startWithSimpleWaveform();
}

void initLineIn() {
	AudioInput input;
	input = minim.getLineIn(Minim.STEREO, width/windowScale);
	currentAudioSource.useAudioInput(input);
	startWithSimpleWaveform();
}

void startWithSimpleWaveform() {
	SimpleWaveform waveform = new SimpleWaveform("First Simple Waveform Scene");
	activeScene = waveform;
}

void draw()
{
	background(0);
	activeScene.drawScene(currentRun);
	currentRun++;
	if (currentRun == 3000) currentRun = 0;
	delay(20);
}