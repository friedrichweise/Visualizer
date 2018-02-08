import ddf.minim.*;

public abstract class Scene {
	private String name;
	public Scene(String name) {
		this.name = name;
	}
	public abstract void drawScene(int currentTimeState);
	public abstract void reactToKeyboardInput(char key);
}