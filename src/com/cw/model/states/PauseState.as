////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.model.states {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: PauseState
	 * language version: ActionScript 3.0
	 * pauseer version: Flash 10.0
	 * author: christian
	 * created: Dec 23, 2011
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.model.MusicPlayerState;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.TweenMax;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class PauseState implements IMusicPlayerState {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var musicPlayerState:MusicPlayerState;
		private var currentTrack:String = 'track1';
		private var currentTrackLoader:MP3Loader;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function PauseState (musicPlayerState:MusicPlayerState) {
			this.musicPlayerState = musicPlayerState;
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function play():void{
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			musicPlayerState.notifyObservers('thePlayStateOn');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
			musicPlayerState.notifyObservers('theStopStateOff');
		}
		public function stop ():void {
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.gotoSoundTime(0);
			currentTrackLoader.pauseSound();
			theTitleText ();
			musicPlayerState.setState(musicPlayerState.getStop());
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function pause ():void {
			TweenMax.killAll(false, false, true);
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			musicPlayerState.notifyObservers('thePlayStateOn');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function next ():void {
		}
		public function back ():void {
		}
		public function forward ():void {
		}
		public function rewind ():void {
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * Method for returning mp3 title text.
		 */
		private function theTitleText ():void {
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			var theMP3Title:String = currentTrackLoader.vars.mp3Title;
			trace(" ::::::::::: MusicPlayerState.theButtonText(nodeName) " + theMP3Title);
		}
	}
}
