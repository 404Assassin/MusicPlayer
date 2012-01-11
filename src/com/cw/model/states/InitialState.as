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
	 * class description: initialState
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Dec 23, 2011
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.model.MusicPlayerState;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class InitialState implements IMusicPlayerState {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var musicPlayerState:MusicPlayerState;
		private var currentTrack:String = 'track1';
		private var currentTrackLoader:MP3Loader;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function InitialState (musicPlayerState:MusicPlayerState) {
			this.musicPlayerState = musicPlayerState;
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function play ():void {
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('thePlayStateOn');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function stop ():void {
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function pause ():void {
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function next ():void {
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function back ():void {
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function forward ():void {
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function rewind ():void {
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	}
}
