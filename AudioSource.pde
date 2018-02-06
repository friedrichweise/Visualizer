import ddf.minim.*;

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
