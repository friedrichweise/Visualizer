public class SimpleWaveform extends Scene {
	private float colorSaturation = 20.0;
	private float colorSaturationMax = 80.0;
	private float colorSaturationMin = 10.0;

	private int upperScaleBoundary = 100;

	private float widthLineVariation = 50;
	private float widthLineVariationMin = 10;

	private float widthDifference = 1;
	private float widthDifferenceMax = 2.8;

	private int yLine1;
	private int yLine2;

	public SimpleWaveform(String name) {
		super(name);
		println("Construct SimpleWaveform with name: ", name);
		this.yLine1 = Math.round(0.25 * height);
		this.yLine2 = Math.round(0.75 * height);
		colorMode(HSB, 100.0);
	}

	private float getCurrentHueForLine1(int step, float run) {
		//float runOffSet = (30.0*cos((run*0.01)+10)+60.0);
		return 10.0*cos(step*0.01);
	}
	private float getCurrentHueForLine2(int step, float run) {
		//float runOffSet = (30.0*cos(run*0.01)+60.0);
		return 10.0*cos(step*0.01);
	}

	private float getCurrentWidth(int step, float run) {
		//float runOffSet = (2*cos(run*0.001)+3);
		return this.widthDifference*cos(step*(1/this.widthLineVariation))+3;
	}


	private float getValueFromAudioBuffer(String type, int i) {
		float value = 0.0;
		if (type=="left") value = currentAudioSource.getLeft(i);
		else if(type=="right") value = currentAudioSource.getRight(i);
		return map(value, -1, 1, 0, this.upperScaleBoundary);
	}

	public void drawScene(float currentTimeState) {
		currentAudioSource.reframe();
		for (int i = 0; i < currentAudioSource.getBufferSize() - 1; i++)
		{
			strokeWeight(getCurrentWidth(i, currentTimeState));

			stroke(getCurrentHueForLine1(i, currentTimeState), this.colorSaturation, 80.0);
			line(i*windowScale, this.yLine1 + getValueFromAudioBuffer("left", i), (i+1)*windowScale, this.yLine1 + getValueFromAudioBuffer("left", i+1));
			stroke(getCurrentHueForLine2(i, currentTimeState), colorSaturation, 80.0);
			line(i*windowScale, this.yLine2 + getValueFromAudioBuffer("right", i), (i+1)*windowScale, this.yLine2 + getValueFromAudioBuffer("right", i+1));
		}
	}
	//@todo: add a more generalized concept of mutations
	public void reactToKeyboardInput(char key) {
		if(key=='o') {
			if(this.colorSaturation < this.colorSaturationMax) this.colorSaturation += 1;
		} else if(key=='l') {
			if(this.colorSaturation > this.colorSaturationMin) this.colorSaturation -= 1;
		} else if(key=='i') {
			this.upperScaleBoundary += 3;
		} else if(key=='k') {
			this.upperScaleBoundary -= 3;
		} else if(key=='u') {
			if(this.widthLineVariation > this.widthLineVariationMin) this.widthLineVariation -= 5;
		} else if(key=='j') {
			this.widthLineVariation += 5;
		} else if(key=='z') {
			if(this.widthDifference < this.widthDifferenceMax) this.widthDifference += 0.1;
		} else if(key=='h') {
			if(this.widthDifference > 0.1) this.widthDifference -= 0.1;
		}
		String debugString = "Current Values: \n Saturation: "+this.colorSaturation+"\n UpperBoundary: "+this.upperScaleBoundary+"\nWidthLineVariation: "+this.widthLineVariation+"\nWidthDifference: "+this.widthDifference+"\n---------------";
		println(debugString);
	}
}
