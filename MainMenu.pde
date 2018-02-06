public class MainMenu extends Scene {
	private	PFont font;
	private int fontSize = 12;
	private int lineHeight = this.fontSize+5;

	public MainMenu(String name) {
		//init font
		println("Construct menu with name: ", name);
		this.font = createFont("Monospaced", this.fontSize);
		textFont(this.font);
		//selectInput("Select a file to play", "fileSelected");
	}

	public void drawScene(int currentTimeState) {
		fill(255);
		ArrayList<String> lines = new ArrayList<String>();
		//@todo: reverse order
		lines.add("-----------------------------------------------------");
		lines.add("from your default input device (!!Highly Beta!!).");
		lines.add("Press key 2 to start the visualizer with the signal  ");
		lines.add("Press key 1 to start the visualizer for selected file.");
		lines.add("-------------- Welcome to the visulizer ------------");
		
		for(int i=(lines.size()-1); i>=0; i--) {
			text(lines.get(i), 70, height - (this.lineHeight*(i+1)) - 150);
		}
		text("-!!- Escape to this Menu by pressing 'b' during live mode -!--", 70, 100);
	}

	public void reactToKeyboardInput(char key) {

	}
}



