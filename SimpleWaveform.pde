public class SimpleWaveform extends Scene {
	private float colorSaturation = 20.0;
	private float colorSaturationMax = 80.0;
	private float colorSaturationMin = 10.0;

	private int upperScaleBoundary = 100;

	private float internalLineVariation = 80;
	private float internalLineVariationMin = 30;

	private float widthDifference = 1;
	private float widthDifferenceMax = 5.0; 

	private int numberOfLines = 2;

	public SimpleWaveform(String name) {
		super(name);
		println("Construct SimpleWaveform with name: ", name);
		colorMode(HSB, 100.0);
	}

	private float getCurrentHueForLine(int step, float run, int line) {
		float lineDrift = map(line, 0, this.numberOfLines, 0, 6);
		float runOffSet = (25.0*cos((run*0.6+lineDrift))+50.0);
		return 6.0*cos(step*(1/this.internalLineVariation))+6.0+runOffSet;
	}

	private float getCurrentWidth(int step) {
		return this.widthDifference*cos(step*(1/this.internalLineVariation))+this.widthDifference+3;
	}


	private float getValueFromAudioBuffer(String type, int i) {
		float value = 0.0;
		if (type=="left") value = currentAudioSource.getLeft(i);
		else if(type=="right") value = currentAudioSource.getRight(i);
		else if(type=="center") value = currentAudioSource.getCenter(i);
		return map(value, -1, 1, 0, this.upperScaleBoundary);
	}

	public void drawScene(float currentTimeState) {
		float singleLineStep = 1.0/((float)this.numberOfLines+1.0);
		currentAudioSource.reframe();
		//each line
		for(int line=1; line<=this.numberOfLines; line++) {
			//calculate y position of each line
			int y = Math.round(((float)(line)*singleLineStep) * height);
			for (int i = 0; i < currentAudioSource.getBufferSize() - 1; i++) {
				strokeWeight(getCurrentWidth(i));
				stroke(getCurrentHueForLine(i, currentTimeState, line), this.colorSaturation, 80.0);
				line(i*windowScale, y + getValueFromAudioBuffer("center", i), (i+1)*windowScale, y + getValueFromAudioBuffer("center", i+1));
			}
		}
	}
	//@todo: add a more generalized concept of mutations
	public void reactToKeyboardInput(char key) {
		if(key=='o') {
			if(this.colorSaturation < this.colorSaturationMax) this.colorSaturation += 1;
		} else if(key=='l') {
			if(this.colorSaturation > this.colorSaturationMin) this.colorSaturation -= 1;
		} else if(key=='i') {
			this.upperScaleBoundary += 2;
		} else if(key=='k') {
			this.upperScaleBoundary -= 2;
		} else if(key=='u') {
			if(this.internalLineVariation > this.internalLineVariationMin) this.internalLineVariation -= 5;
		} else if(key=='j') {
			this.internalLineVariation += 5;
		} else if(key=='z') {
			if(this.widthDifference < this.widthDifferenceMax) this.widthDifference += 0.1;
		} else if(key=='h') {
			if(this.widthDifference > 0.1) this.widthDifference -= 0.1;
		} else if(key=='q') {
			if(this.numberOfLines < 20) this.numberOfLines++;
		} else if(key=='a') {
			if(this.numberOfLines > 2) this.numberOfLines--;
		}
		String debugString = "Current Values: \n Saturation: "+this.colorSaturation+"\n UpperBoundary: "+this.upperScaleBoundary+"\ninternalLineVariation: "+this.internalLineVariation+"\nWidthDifference: "+this.widthDifference+"\n---------------";
		println(debugString);
	}
}
