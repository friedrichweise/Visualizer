# Visualizer
<i>A simple audio Visualizer written in Processing using the minim library</i>

<img src="demo.gif" style="margin: 2em auto; display: block;">

## Developer
* install Processing
	* macOS by running `brew cask install processing`
* install the `processing-java` command line tool
* navigate to the folder und start the application by running the `start.sh` script

## Architecture
`visualizer.pde` loads the MainMenu Scene, wich is a subclass of an abstract Scene class, and waits for the selection of an input device. After the selection, the `currentScene` is switched in favor of the SimpleWaveform Scene. 