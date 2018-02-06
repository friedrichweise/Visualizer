import ddf.minim.*;

public abstract class Scene {
	private String name;
	private int windowWidth = 0;
	private int windowHeight = 0;
	public void initSceneWithName(String name, int windowHeight, int windowWidth) {
		this.name = name;
		this.windowHeight = windowHeight;
		this.windowWidth = windowWidth;
	}
	public void drawScene(int currentTimeState) {
		//@todo: implement specific drawing code
	}
	public void reactToKeyboardInput(char key) {
		//@todo: implement specific code for keyboard events
	}
}