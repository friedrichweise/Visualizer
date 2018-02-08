public class SimpleWaveform extends Scene {
	private int lineScale = 100;
	private float colorSaturation = 20.0;
	private int yLine1;
	private int yLine2;

	public SimpleWaveform(String name) {
		super(name);
		println("Construct SimpleWaveform with name: ", name);
		this.yLine1 = Math.round(0.25 * height);
		this.yLine2 = Math.round(0.75 * height);
		colorMode(HSB, 100.0);
	}

	private float getCurrentHueForLine1(int step, int run) {
		float runOffSet = (30.0*cos((run*0.01)+10)+60.0);
		return 10.0*cos(step*0.01)+runOffSet;
	}
	private float getCurrentHueForLine2(int step, int run) {
		float runOffSet = (30.0*cos(run*0.01)+60.0);
		return 10.0*cos(step*0.01)+runOffSet;
	}

	private float getCurrentWidth(int step, int run) {
		float runOffSet = (2*cos(run*0.001)+3);
		return cos(step*0.03)+runOffSet;
	}

	public void drawScene(int currentTimeState) {
		currentAudioSource.reframe();
		for (int i = 0; i < currentAudioSource.getBufferSize() - 1; i++)
		{
			float currentWidth = getCurrentWidth(i, currentTimeState);
			float currentHue = getCurrentHueForLine1(i, currentTimeState);
			
			strokeWeight(currentWidth);
			stroke(currentHue, this.colorSaturation, 80.0);
			line(i*windowScale, this.yLine1 + currentAudioSource.getLeft(i)*lineScale, (i+1)*windowScale, this.yLine1 + currentAudioSource.getLeft(i+1)*lineScale);
			stroke(getCurrentHueForLine2(i, currentTimeState), colorSaturation, 80.0);
			line(i*windowScale, this.yLine2 + currentAudioSource.getRight(i)*lineScale, (i+1)*windowScale, this.yLine2 + currentAudioSource.getRight(i+1)*lineScale);
		}
	}
	public void reactToKeyboardInput(char key) {
		return;
	}
}
