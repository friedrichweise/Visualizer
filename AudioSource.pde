import ddf.minim.*;

public class AudioSource {
	private AudioPlayer audioPlayer = null;
	private AudioInput audioInput = null;

	private float[] currentLeftSet;
	private float[] currentRightSet;
	
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
		return this.currentLeftSet[i];
	}
	public float getRight(int i) {
		return this.currentRightSet[i];
	}
	public int getBufferSize() {
		if (this.audioPlayer == null && this.audioInput != null) {
			return this.audioInput.bufferSize();
		} else if (this.audioInput == null && this.audioPlayer != null)  {
			return this.audioPlayer.bufferSize();
		} else return 0;
	}
	public void reframe() {
		if (this.audioInput != null) {
			this.currentLeftSet = this.audioInput.left.toArray();
			this.currentRightSet = this.audioInput.right.toArray();
		}
		else if (this.audioPlayer != null) {
			this.currentLeftSet = this.audioPlayer.left.toArray();
			this.currentRightSet = this.audioPlayer.right.toArray();			
		}
		
	}
}
