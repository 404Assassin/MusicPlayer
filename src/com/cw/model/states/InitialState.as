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
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class InitialState implements IMusicPlayerState {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var musicPlayerState:MusicPlayerState;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function InitialState (musicPlayerState:MusicPlayerState) {
			this.musicPlayerState = musicPlayerState;
			trace(" ::::::::::: InitialState.InitialState() " + musicPlayerState);
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function play ():void {
			trace(" ::::::::::: InitialState.play() " + musicPlayerState);
			musicPlayerState.setState(musicPlayerState.getPlay());
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
		public function stop ():void {
			trace(" ::::::::::: InitialState.stop() ");
			musicPlayerState.setState(musicPlayerState.getStop());
			musicPlayerState.notifyObservers('theStopStateOn');
			musicPlayerState.notifyObservers('thePlayStateOff');
		}
		public function pause ():void {
			trace(" ::::::::::: InitialState.pause() ");
		}
		public function next ():void {
			trace(" ::::::::::: InitialState.next() ");
		}
		public function back ():void {
			trace(" ::::::::::: InitialState.back() ");
		}
		public function forward ():void {
			trace(" ::::::::::: InitialState.forward() ");
		}
		public function rewind ():void {
			trace(" ::::::::::: InitialState.rewind() ");
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	}
}
