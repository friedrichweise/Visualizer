import ddf.minim.*;

public class MainMenu extends Scene {
	private	PFont font;
	private int fontSize = 10;
	private int lineHeight = this.fontSize+5;
	public void initSceneWithName(String name) {
		//init font
		this.font = createFont("Monospaced", this.fontSize);
		textFont(this.font);
	}
	public void drawScene(int currentTimeState) {
		fill(255);
		String[] lines = ["Welcome to the visulizer", "Press key 1 to start the visualizer for the following file: "+audioFilePath, "Press key 2 to start the visualizer with the signal from your default input device."];
		for(int i=lines.length()-1; i<=0; i--) {
			text(lines[i], 20, height(lineHeight*(i+1));
		}
/*		text("Welcome to the visulizer", 20, height-(lineHeight*4));
		text("Press key 1 to start the visualizer for the following file: "+audioFilePath, 20, height-(lineHeight*3));
		text("Press key 2 to start the visualizer with the signal from your default input device.", 20, height-(lineHeight*2));
		text("Press key b to start the selected visualizer.", 20, height-(lineHeight));*/
	}
	public void reactToKeyboardInput(String key) {
		//@todo
		println('Key pushed: ', key);
	}
}

