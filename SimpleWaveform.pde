import ddf.minim.*;

public class SimpleWaveform extends Scene {
	private float runOffSet = 0.0;
	private int lineScale = 100;
	private float colorSaturation = 20.0;

	public void initSceneWithName(String name) {
	}

	private int yLine1;
	private int yLine2;
void prepareDraw() {
	//init routine
	this.yLine1 = Math.round(0.25 * windowHeight);
	this.yLine2 = Math.round(0.75 * windowHeight);
	colorMode(HSB, 100.0);
}
	/*
	 * helper cosine function definitions
	 */
	private float getCurrentHueForLine1(int step, int run) {
		this.runOffSet = (30.0*cos((run*0.01)+10)+60.0);
		return 10.0*cos(step*0.01)+this.runOffSet;
	}
	private float getCurrentHueForLine2(int step, int run) {
		this.runOffSet = (30.0*cos(run*0.01)+60.0);
		return 10.0*cos(step*0.01)+this.runOffSet;
	}

	private float getCurrentWidth(int step, int run) {
		this.runOffSet = (2*cos(run*0.001)+3);
		return cos(step*0.03)+this.runOffSet;
	}
	/*
	 * main draw methods
	 */
	public void drawScene(int currentTimeState) {
		for (int i = 0; i < currentAudioSource.getBufferSize() - 1; i++)
		{
			strokeWeight(getCurrentWidth(i, currentTimeState));
			stroke(getCurrentHueForLine1(i, currentTimeState), colorSaturation, 80.0);
			line(i*windowScale, this.yLine1 + currentAudioSource.getLeft(i)*lineScale, (i+1)*windowScale, this.yLine1 + currentAudioSource.getLeft(i+1)*lineScale);
			stroke(getCurrentHueForLine2(i, currentTimeState), colorSaturation, 80.0);
			line(i*windowScale, this.yLine2 + currentAudioSource.getRight(i)*lineScale, (i+1)*windowScale, this.yLine2 + currentAudioSource.getRight(i+1)*lineScale);
		}
	}
}

/* ---------------------------------------*/
/* ---------------------------------------*/
/* ---------------------------------------*/
/* ---------------------------------------*/