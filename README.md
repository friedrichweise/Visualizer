# Visualizer – Villa Edition
<img src="images/demo_03.gif" style="margin: 2em auto; display: block;">

A simple waveform based audio Visualizer written in Processing utilizing the <a href="http://code.compartmental.net/tools/minim/">minim library</a>. It allows you to play files from your file system or select the internal microphone as an audio input. Additionally you can manipulate the Visualization using the keyboard. The following parameters are adjustable:
* number of waveforms
* saturation of color
* thickness (and the variation of the thickness) of each line

To make the animation even more organic there are time based manipulations changing color and thickness of the lines based on sine waves.

<a href="https://github.com/Stunkymonkey">Stunkymonkey</a> built a <a href="http://projectm.sourceforge.net">projectM</a> plugin based on this Visualizer:
<a href="https://github.com/Stunkymonkey/projectm-visualization">https://github.com/Stunkymonkey/projectm-visualization</a>

## Images
<img src="images/demo_01.gif" style="margin: 2em auto; display: block;">

<img src="images/menu.png" style="margin: 2em auto; display: block;">

<img src="images/demo_02.gif" style="margin: 2em auto; display: block;">

## Developing Setup
* Install <a href="http://processing.org">Processing</a>
	* macOS: `brew cask install processing`
* Install the `processing-java` command line tool
* Navigate to the folder und start the application by executing the `start.sh` script

## Architecture
`visualizer.pde` loads the MainMenu Scene, wich is a subclass of an abstract Scene class, and waits for the selection of an input device. After the selection, the `currentScene` is switched in favour of the SimpleWaveform Scene. This is where the main logic of the Visualizer is implemented.