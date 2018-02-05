import ddf.minim.*;

Minim minim;
PFont font;

public class AudioSource {
	private AudioPlayer audioPlayer = null;
	private AudioInput audioInput = null;
	
	public void useAudioPlayer(AudioPlayer p) {
		println("Use AudioPlayer");
		this.audioPlayer = p;
		this.audioInput = null;
	}
	public void useAudioInput(AudioInput i) {
		println("Use AudioInput");
		this.audioInput = i;
		this.audioPlayer = null;
	}
	public float getLeft(int i) {
		if (this.audioPlayer == null) return this.audioInput.left.get(i);
		else if (this.audioInput == null) return this.audioPlayer.left.get(i);
		else return 0.0;
	}
	public float getRight(int i) {
		if (this.audioPlayer == null) return this.audioInput.right.get(i);
		else if (this.audioInput == null) return this.audioPlayer.right.get(i);
		else return 0.0;
	}
	public int getBufferSize() {
		if (this.audioPlayer == null && this.audioInput != null) {
			return this.audioInput.bufferSize();
		} else if (this.audioInput == null && this.audioPlayer != null)  {
			return this.audioPlayer.bufferSize();
		} else return 0;
	}
}

int fontSize = 10;
int lineHeight = fontSize+5;
void setup()
{
	size(800, 200);
	surface.setTitle("Visualizer");
	font = createFont ("Monospaced", fontSize);
	textFont(font);
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
	if (running) {
		drawWaveform();
	} else {
		drawMainMenu();
	}
}

void drawMainMenu() {
	fill(255);
	text("Welcome to the visulizer", 20, height-(lineHeight*4));
	text("Press key 1 to start the visualizer for the following file: "+audioFilePath, 20, height-(lineHeight*3));
	text("Press key 2 to start the visualizer with the signal from your default input device.", 20, height-(lineHeight*2));
	text("Press key b to start the selected visualizer.", 20, height-(lineHeight));
}

void drawWaveform() {
	println(currentAudioSource.getBufferSize());
	for (int i = 0; i < currentAudioSource.getBufferSize() - 1; i++)
	{
		strokeWeight(getCurrentWidth(i, currentRun));
		stroke(getCurrentHueForLine1(i, currentRun), colorSaturation, 80.0);
		line(i*windowScale, yLine1 + currentAudioSource.getLeft(i)*lineScale, (i+1)*windowScale, yLine1 + currentAudioSource.getLeft(i+1)*lineScale);
		stroke(getCurrentHueForLine2(i, currentRun), colorSaturation, 80.0);
		line(i*windowScale, yLine2 + currentAudioSource.getRight(i)*lineScale, (i+1)*windowScale, yLine2 + currentAudioSource.getRight(i+1)*lineScale);
	}
	currentRun++;
	if (currentRun == 3000) currentRun = 0;
	delay(20);
}
